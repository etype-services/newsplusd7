<?php
/**
 * This script is necessary setup automated data exchange 
 * between Your/Merchant site and CMS2CMS.
 *
 * Please carefully follow steps below.
 *
 * Requirements
 * ===========================================================================
 * PHP 5.1.x - 7.x
 * PHP Extensions: CURL (libcurl)
 *
 * Installation Instructions
 * ===========================================================================
 * 1. Extract files from archive and upload "cms2cms" folder into your site 
 *    root catalog via FTP.
 *    Example how to upload: "http://www.yourstore.com/cms2cms"
 * 2. Make "cms2cms" folder writable (set the 777 permissions, "write for all")
 * 3. Press Continue in Migration Wizard at CMS2CMS to check compatibility
 *    You are done.
 *
 * If you have any questions or issues
 * ===========================================================================
 * 1. Check steps again, startign from step 1
 * 2. See Frequently Asked Questions at http://cms2cms.com/faq
 * 3. Send email (support@cms2cms.com) to CMS2CMS support requesting help.
 * 4. Add feedback on http://cms2cms.betaeasy.com/
 *
 * Most likely you uploaded this script into wrong folder 
 * or misstyped the site address.
 *
 * DISCLAIMER
 * ===========================================================================
 * THIS SOFTWARE IS PROVIDED BY CMS2CMS ``AS IS'' AND ANY
 * EXPRESSED OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL CMS2CMS OR ITS
 * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
 * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
 * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
 * OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
 * WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
 * OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
 * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 * CMS2CMS by MagneticOne
 * (c) 2010-2016 MagneticOne.com <contact@cms2cms.com>
 */

/**
 * Class Bridge_Exception
 */
class Bridge_Exception extends Exception
{

    /**
     * Define error codes
     */
    const ERROR_UNDEFINED = 0;

    /**
     * Database exceptions codes
     */
    const ERROR_DB_CONNECT       = 1;
    const ERROR_DB_QUERY_INVALID = 2;
    const ERROR_DB_QUERY_FAILED  = 3;

    /**
     * Filesystem exceptions codes
     */
    const ERROR_FS_ERROR          = 4;
    const ERROR_FS_FILE_NOT_EXIST = 5;
    const ERROR_FS_FILE_EXISTS    = 6;

    /**
     * Update exceptions codes
     */
    const ERROR_UPDATE_ERROR = 7;

    /**
     * Detected invalid settings in bridge
     */
    const ERROR_PLATFORM_VALID = 8;
    const ERROR_BRIDGE_VALID   = 9;

    /**
     * Handled errors codes
     */
    const ERROR_HANDLED_WARNING = 10;
    const ERROR_HANDLED_FATAL   = 11;

    /**
     * Exception as array keys
     */
    const MESSAGE = 'message';
    const CODE    = 'code';
    const FILE    = 'file';
    const LINE    = 'line';
    const TRACE   = 'trace';

    /**
     * @return array
     */
    public static function getErrorHandler()
    {
        return array('Bridge_Exception', 'errorHandler');
    }

    /**
     * Handling fatal errors
     * @return void
     */
    public static function errorHandler()
    {
        if (null !== ($error = error_get_last())) {
            switch ($error['type']) {
                case E_ERROR:
                case E_CORE_ERROR:
                case E_RECOVERABLE_ERROR:
                case E_COMPILE_ERROR:
                    $response = new Bridge_Library_Response();

                    $response->sendException(
                        new Bridge_Exception(
                            sprintf('Message: %s File: %s Line: %s', $error['message'], $error['file'], $error['line'])
                        )
                    );
                    break;
                default:
                    break;
            }
        }
    }

}

/**
 * Class Bridge_Request
 */
class Bridge_Library_Request
{

    /**
     * Module list
     */
    const MODULE_INFO   = 'info';
    const MODULE_DB     = 'db';
    const MODULE_FS     = 'fs';
    const MODULE_UPDATE = 'update';

    /**
     * @var ArrayObject
     */
    protected $params;

    /**
     * Bridge_Request constructor.
     * @param mixed $request Request
     */
    public function __construct($request)
    {
        $this->init();

        if (get_magic_quotes_gpc()) {
            foreach ($request as $param => $value) {
                unset($request[$param]);
                if (is_array($value)) {
                    $request[stripslashes($param)] = $value;
                } else {
                    $request[stripslashes($param)] = stripslashes($value);
                }
            }
        }

        $this->params = new ArrayObject($request);
    }

    /**
     * @param string $name    Name
     * @param null   $default Default
     * @return mixed|null
     */
    public function getParam($name, $default = null)
    {
        if ($this->params->offsetExists($name)) {
            return $this->params->offsetGet($name);
        }

        return $default;
    }

    /**
     * Handle request
     * @return void
     */
    public function handle()
    {
        $module = $this->getParam('module');

        $params = unserialize(base64_decode($this->getParam('params', '')));

        if (null === $params) {
            $params = array();
        }

        try {
            $moduleClass = 'Bridge_Module_' . ucfirst($module);
            if (false === class_exists($moduleClass)) {
                throw new Bridge_Exception('Class ' . $moduleClass . 'doesn\'t exist', Bridge_Exception::ERROR_BRIDGE_VALID);
            }

            if (false === defined('CMS2CMS_KEY')) {
                throw new Bridge_Exception('CMS2CMS_KEY is not accessible', Bridge_Exception::ERROR_BRIDGE_VALID);
            }

            if ($this->getParam('key') !== CMS2CMS_KEY) {
                throw new Bridge_Exception('Key is invalid', Bridge_Exception::ERROR_BRIDGE_VALID);
            }

            /** @var Bridge_Module_Abstract $module */
            $module = new $moduleClass($params);
            $module->run();
            $module->getResponse()->send();

        } catch (Exception $exception) {
            $response = new Bridge_Library_Response();
            $response->sendException($exception);
        }
    }

    /**
     * init request
     * @return void
     */
    protected function init()
    {
        if (version_compare(phpversion(), CMS2CMS_MINIMUM_PHP_VERSION) == -1) {
            exit('PHP version (' . phpversion() . ') is not supported. Version ' . CMS2CMS_MINIMUM_PHP_VERSION . ' required');
        }

        if ($_SERVER['REQUEST_METHOD'] !== 'POST' && (false == isset($_GET['module']) || $_GET['module'] != self::MODULE_FS)) {
            exit('Bridge successfully installed');
        }

        @set_time_limit(0);
        @error_reporting(E_ALL);
        @ini_set('display_errors', true);
        @ini_set('max_execution_time', 0);

        set_error_handler(Bridge_Exception::getErrorHandler());
        register_shutdown_function(Bridge_Exception::getErrorHandler());
    }

}

/**
 * Class Bridge_Response
 */
class Bridge_Library_Response
{

    /**
     * @var array
     */
    protected $data = array();

    /**
     * @var array
     */
    protected $headers = array(
        'Content-Encoding: text'   => null,
        'Content-Type: text/plain' => null
    );

    /**
     * Bridge_Library_Response constructor.
     * @param array $data Data
     */
    public function __construct($data = array())
    {
        $this->data = $data;
    }

    /**
     * @param mixed $key   Key
     * @param null  $value Value
     * @return void
     */
    public function add($key, $value = null)
    {
        $this->data += is_array($key) ? $key : array($key => $value);
    }

    /**
     * @param string $string       String
     * @param null   $responseCode Responce code
     * @return   void
     */
    public function addHeader($string, $responseCode = null)
    {
        $this->headers[$string] = $responseCode;
    }

    /**
     * Send response
     * @return void
     */
    public function send()
    {
        if (false === headers_sent()) {
            foreach ($this->headers as $string => $responseCode) {
                header($string, true, $responseCode);
            }
        }

        $responseData = serialize($this->data);
        $responseData = gzdeflate($responseData);
        $responseData = base64_encode($responseData);

        echo $responseData;
    }

    /**
     * @param Exception $exception Exception
     * @return void
     */
    public function sendException(Exception $exception)
    {
        $this->add(
            array(
                Bridge_Exception::MESSAGE => $exception->getMessage(),
                Bridge_Exception::CODE    => $exception->getCode(),
                Bridge_Exception::LINE    => $exception->getLine(),
                Bridge_Exception::FILE    => $exception->getFile(),
                Bridge_Exception::TRACE   => $exception->getTrace()
            )
        );

        $this->addHeader('HTTP/1.1 500 Internal Server Error', 500);
        $this->send();
    }

}

/**
 * Class Bridge_System
 */
class Bridge_Library_System
{

    /**
     * @var Bridge_Library_System
     */
    private static $instance;

    /**
     * @return Bridge_Library_System
     */
    public static function getInstance()
    {
        if (null === self::$instance) {
            self::$instance = new Bridge_Library_System();
        }

        return self::$instance;
    }

    /**
     * @param null $type Type
     * @return Bridge_Platform_Abstract|null
     * @throws Bridge_Exception
     */
    public function factoryPlatform($type = null)
    {
        $platform = null;

        if (null !== $type) {
            $platform = $this->loadPlatform($type);
        }

        if (true === $platform instanceof Bridge_Platform_Abstract) {
            return $platform;
        } else {
            foreach (Bridge_Platform_Abstract::platformList() as $platformType) {
                if (null !== ($platform = $this->loadPlatform($platformType))) {
                    return $platform;
                }
            }
        }

        throw new Bridge_Exception('Can not load platform', Bridge_Exception::ERROR_PLATFORM_VALID);
    }

    /**
     * @param string $type Type
     * @return Bridge_Platform_Abstract|null
     */
    protected function loadPlatform($type)
    {
        $className = 'Bridge_Platform_' . $type;

        if (true === @class_exists($className)) {
            /** @var Bridge_Platform_Abstract $platform */
            $platform = new $className();
            if (false !== $platform->valid()) {
                $platform->getConfiguration();
                $this->loadParentPlatform($platform);

                return $platform;
            }
        }

        return null;
    }

    /**
     * @param Bridge_Platform_Abstract $platform platform
     * @return void
     */
    private function loadParentPlatform(&$platform)
    {
        $parentPlatformType = $platform->parent(Bridge_Platform_Abstract::PLATFORM_TYPE);
        if (null != $parentPlatformType) {
            $parentPlatform = $this->loadPlatform($parentPlatformType);
            if (null != $parentPlatform) {
                $platform->parent(Bridge_Platform_Abstract::PLATFORM_TYPE, $parentPlatform->type());
                $platform->parent(Bridge_Platform_Abstract::PLATFORM_VERSION, $parentPlatform->version());
                $platform->parent(
                    Bridge_Platform_Abstract::PLATFORM_IMAGES_PATH,
                    $parentPlatform->files(Bridge_Platform_Abstract::PLATFORM_IMAGES_PATH)
                );
                $platform->parent(
                    Bridge_Platform_Abstract::PLATFORM_IMAGES_WRITABLE,
                    $parentPlatform->files(Bridge_Platform_Abstract::PLATFORM_IMAGES_WRITABLE)
                );
                $platform->parent(
                    Bridge_Platform_Abstract::PLATFORM_ATTACHMENTS_PATH,
                    $parentPlatform->files(Bridge_Platform_Abstract::PLATFORM_ATTACHMENTS_PATH)
                );
                $platform->parent(
                    Bridge_Platform_Abstract::PLATFORM_ATTACHMENTS_WRITABLE,
                    $parentPlatform->files(Bridge_Platform_Abstract::PLATFORM_ATTACHMENTS_WRITABLE)
                );

                if (null == $platform->database(Bridge_Platform_Abstract::DATABASE_DATABASE)) {
                    $dbConfigs = array(
                        Bridge_Platform_Abstract::DATABASE_HOST,
                        Bridge_Platform_Abstract::DATABASE_USER,
                        Bridge_Platform_Abstract::DATABASE_PASSWORD,
                        Bridge_Platform_Abstract::DATABASE_DATABASE,
                        Bridge_Platform_Abstract::DATABASE_PORT,
                        Bridge_Platform_Abstract::DATABASE_SOCKET,
                        Bridge_Platform_Abstract::DATABASE_PREFIX,
                        Bridge_Platform_Abstract::DATABASE_CHARSET,
                        Bridge_Platform_Abstract::DATABASE_VERSION
                    );
                    foreach ($dbConfigs as $key) {
                        $platform->database($key, $parentPlatform->database($key));
                    }
                }
            }
        }
    }

}

/**
 * Interface Bridge_Db_Interface
 */
abstract class Bridge_Library_Db_Abstract
{

    /**
     * Define Sql modes
     */
    const SQL_MODE_FETCH_ASSOC = 1;
    const SQL_MODE_FETCH_NUM   = 2;
    const SQL_MODE_FETCH_BOTH  = 3;

    /**
     * Error message pattern
     */
    const ERROR_MESSAGE_PATTERN = '\'Mysql Error. Message: \'%s\'. Code: \'%s\'. Adapter: \'%s\'';

    /**
     * @var mixed
     */
    protected $link;

    /**
     * @var mixed
     */
    protected $statement = null;

    /**
     * @return mixed
     * @throws Bridge_Exception
     */
    public function getStatement()
    {
        if (null === $this->statement) {
            throw new Bridge_Exception('Query wasn\'t executed', Bridge_Exception::ERROR_DB_QUERY_INVALID);
        }

        return $this->statement;
    }

    /**
     * @param mixed $statement Statement
     * @return void
     */
    public function setStatement($statement)
    {
        $statement       = $this->handleStatement($statement);
        $this->statement = $statement;
    }

    /**
     * @return void
     */
    public function preConfig()
    {
        $mode = 'NO_AUTO_VALUE_ON_ZERO';
        if ($result = $this->query("SELECT @@SESSION.sql_mode as mode")->fetch()) {
            $mode = explode(',', $result[0]['mode']);
            $incompatibleModes = array(
                'NO_ZERO_DATE', 'NO_ZERO_IN_DATE', 'TRADITIONAL', 'STRICT_TRANS_TABLES', 'STRICT_ALL_TABLES'
            );
            foreach ($mode as $key => $item) {
                if (!$item || in_array($item, $incompatibleModes)) {
                    unset($mode[$key]);
                }
            }

            $mode = implode(',', $mode);
        }

        $this->query("SET SESSION sql_mode='$mode'");
        $this->statement = null;
    }

    /**
     * @param mixed $statement Statement
     *
     * @return mixed
     */
    abstract public function handleStatement($statement);

    /**
     * Bridge_Db_Interface constructor.
     * @param array $config Config
     */
    abstract public function __construct(array $config);

    /**
     * @param string $sql Sql
     *
     * @return $this
     */
    abstract public function query($sql);

    /**
     * @param int $mode Mode
     * @return mixed
     */
    abstract public function fetch($mode = self::SQL_MODE_FETCH_ASSOC);

    /**
     * @return int
     */
    abstract public function affectedRows();

    /**
     * @return mixed
     */
    abstract public function rowsCount();

    /**
     * @return mixed
     */
    abstract public function columnCount();

    /**
     * @return int|string
     */
    abstract public function lastInsertId();

    /**
     * @return mixed
     */
    abstract public function errorCode();

    /**
     * @return mixed
     */
    abstract public function errorMessage();

    /**
     * @param string $string String
     * @return mixed
     */
    abstract public function escape($string);

}

/**
 * Class Bridge_Db_Mysql
 *
 * @property resource $link
 * @property resource $statement
 *
 * @method   resource getStatement()
 */
class Bridge_Library_Db_Mysql extends Bridge_Library_Db_Abstract
{

    /**
     * Bridge_Db_Mysql constructor.
     * @param array $config Config
     * @throws Bridge_Exception
     */
    public function __construct(array $config)
    {
        $this->link = mysql_connect(
            sprintf(
                '%s:%s',
                $config[Bridge_Platform_Abstract::DATABASE_HOST],
                $config[Bridge_Platform_Abstract::DATABASE_SOCKET] ? $config[Bridge_Platform_Abstract::DATABASE_SOCKET] : $config[Bridge_Platform_Abstract::DATABASE_PORT]
            ),
            $config[Bridge_Platform_Abstract::DATABASE_USER],
            $config[Bridge_Platform_Abstract::DATABASE_PASSWORD]
        );

        if (false === $this->link
            || false === mysql_select_db($config[Bridge_Platform_Abstract::DATABASE_DATABASE], $this->link)
        ) {
            throw new Bridge_Exception($this->errorMessage(), Bridge_Exception::ERROR_DB_CONNECT);
        }

        mysql_set_charset(
            $config[Bridge_Platform_Abstract::DATABASE_CHARSET] ? $config[Bridge_Platform_Abstract::DATABASE_CHARSET] : 'utf8'
        );
    }

    /**
     * @param string $sql Sql
     * @return $this
     * @throws Bridge_Exception
     */
    public function query($sql)
    {
        $this->setStatement(mysql_query($sql, $this->link));
        return $this;
    }

    /**
     * @param mixed $statement statement
     *
     * @return mixed
     *
     * @throws Bridge_Exception
     */
    public function handleStatement($statement)
    {
        // handle mysql error
        if (false === $statement) {
            throw new Bridge_Exception($this->errorMessage(), Bridge_Exception::ERROR_DB_CONNECT);
        }

        return $statement;
    }

    /**
     * @param int $mode Mode
     * @return array
     */
    public function fetch($mode = self::SQL_MODE_FETCH_ASSOC)
    {
        $data = array();

        while ($row = mysql_fetch_array($this->getStatement(), $mode)) {
            $data[] = $row;
        }

        return $data;
    }

    /**
     * @return int
     */
    public function affectedRows()
    {
        return mysql_affected_rows($this->link);
    }

    /**
     * @return int
     */
    public function rowsCount()
    {
        return mysql_num_rows($this->getStatement());
    }

    /**
     * @return int
     */
    public function columnCount()
    {
        return mysql_num_fields($this->getStatement());
    }

    /**
     * @return int
     */
    public function lastInsertId()
    {
        return mysql_insert_id($this->link);
    }

    /**
     * @return int
     */
    public function errorCode()
    {
        return mysql_errno($this->link);
    }

    /**
     * @return string
     */
    public function errorMessage()
    {
        return sprintf(self::ERROR_MESSAGE_PATTERN, mysql_error($this->link), $this->errorCode(), 'mysql');
    }

    /**
     * @param string $string String
     * @return string
     */
    public function escape($string)
    {
        return mysql_escape_string($string);
    }

}

/**
 * Class Bridge_Db_Mysqli
 *
 * @property mysqli        $link
 * @property mysqli_result $statement
 *
 * @method   mysqli_result getStatement()
 */
class Bridge_Library_Db_Mysqli extends Bridge_Library_Db_Abstract
{

    /**
     * Bridge_Db_Mysqli constructor.
     * @param array $config Config
     * @throws Bridge_Exception
     */
    public function __construct(array $config)
    {
        $this->link = new mysqli(
            $config[Bridge_Platform_Abstract::DATABASE_HOST],
            $config[Bridge_Platform_Abstract::DATABASE_USER],
            $config[Bridge_Platform_Abstract::DATABASE_PASSWORD],
            $config[Bridge_Platform_Abstract::DATABASE_DATABASE],
            $config[Bridge_Platform_Abstract::DATABASE_PORT],
            $config[Bridge_Platform_Abstract::DATABASE_SOCKET]
        );

        if ($this->link->connect_errno) {
            throw new Bridge_Exception($this->link->connect_error, Bridge_Exception::ERROR_DB_CONNECT);
        }

        mysqli_set_charset(
            $this->link,
            $config[Bridge_Platform_Abstract::DATABASE_CHARSET] ? $config[Bridge_Platform_Abstract::DATABASE_CHARSET] : 'utf8'
        );
    }

    /**
     * @param string $sql Sql
     * @return $this
     * @throws Exception
     */
    public function query($sql)
    {
        $this->setStatement($this->link->query($sql));
        return $this;
    }

    /**
     * @param mixed $statement Statement
     * @return mixed
     * @throws Exception
     */
    public function handleStatement($statement)
    {
        if (false === $statement) {
            throw new Exception($this->errorMessage(), Bridge_Exception::ERROR_DB_QUERY_INVALID);
        }

        return $statement;
    }

    /**
     * @param int $mode Mode
     * @return array
     */
    public function fetch($mode = self::SQL_MODE_FETCH_ASSOC)
    {
        $data = array();

        if ($statement = $this->getStatement()) {
            while (false == is_bool($statement) && ($row = $statement->fetch_array($mode))) {
                $data[] = $row;
            }
        }

        return $data;
    }

    /**
     * @return int
     */
    public function affectedRows()
    {
        return $this->link->affected_rows;
    }

    /**
     * @return int
     */
    public function rowsCount()
    {
        $statement = $this->getStatement();
        return $statement instanceof mysqli_result ? $statement->num_rows : 0;
    }

    /**
     * @return int
     */
    public function columnCount()
    {
        $statement = $this->getStatement();
        return $statement instanceof mysqli_result ? mysqli_num_fields($statement) : 0;
    }

    /**
     * @return mixed
     */
    public function lastInsertId()
    {
        return $this->link->insert_id;
    }

    /**
     * @return int
     */
    public function errorCode()
    {
        return $this->link->errno;
    }

    /**
     * @return string
     */
    public function errorMessage()
    {
        return sprintf(self::ERROR_MESSAGE_PATTERN, $this->link->error, $this->errorCode(), 'mysqli');
    }

    /**
     * @param string $string String
     * @return string
     */
    public function escape($string)
    {
        return $this->link->escape_string($string);
    }

}

/**
 * Class Bridge_Adapter_Pdo
 *
 * @property PDO          $link
 * @property PDOStatement $statement
 *
 * @method   PDOStatement getStatement()
 */
class Bridge_Library_Db_Pdo extends Bridge_Library_Db_Abstract
{

    /**
     * @var int
     */
    protected $affectedRows = 0;

    /**
     * Bridge_Db_Pdo constructor.
     * @param array $config Config
     * @throws Bridge_Exception
     */
    public function __construct(array $config)
    {
        $charset = $config[Bridge_Platform_Abstract::DATABASE_CHARSET];
        $socket  = $config[Bridge_Platform_Abstract::DATABASE_SOCKET];
        $dsn = sprintf(
            'mysql:dbname=%s;host=%s;port=%s%s%s',
            $config[Bridge_Platform_Abstract::DATABASE_DATABASE],
            $config[Bridge_Platform_Abstract::DATABASE_HOST],
            $config[Bridge_Platform_Abstract::DATABASE_PORT],
            $socket ? ';unix_socket=' . $socket : '',
            $charset ? ';charset=' . $charset : ''
        );

        try {
            $this->link = new PDO(
                $dsn,
                $config[Bridge_Platform_Abstract::DATABASE_USER],
                $config[Bridge_Platform_Abstract::DATABASE_PASSWORD]
            );
        } catch (PDOException $exception) {
            throw new Bridge_Exception($exception->getMessage(), Bridge_Exception::ERROR_DB_CONNECT);
        }
    }

    /**
     * @return void
     */
    public function preConfig()
    {
        parent::preConfig();
        $this->affectedRows = 0;
    }

    /**
     * @param string $sql Sql
     * @return $this
     */
    public function query($sql)
    {
        $this->setStatement($this->link->query($sql));
        $this->affectedRows = $this->rowsCount();

        return $this;
    }

    /**
     * @param mixed $statement Statement
     * @return PDOStatement
     * @throws Bridge_Exception
     */
    public function handleStatement($statement)
    {
        if (false === $statement || false === $statement instanceof PDOStatement) {
            throw new Bridge_Exception($this->errorMessage(), Bridge_Exception::ERROR_DB_QUERY_FAILED);
        }

        return $statement;
    }

    /**
     * @param int $mode mode
     * @return mixed
     */
    public function fetch($mode = self::SQL_MODE_FETCH_ASSOC)
    {
        $modes = array(
            self::SQL_MODE_FETCH_ASSOC => PDO::FETCH_ASSOC,
            self::SQL_MODE_FETCH_NUM   => PDO::FETCH_NUM,
            self::SQL_MODE_FETCH_BOTH  => PDO::FETCH_BOTH,
        );

        $mode = true === isset($modes[$mode]) ? $modes[$mode] : PDO::FETCH_ASSOC;

        return $this->getStatement()->fetchAll($mode);
    }

    /**
     * @return int
     */
    public function affectedRows()
    {
        return $this->affectedRows;
    }

    /**
     * @return mixed
     */
    public function rowsCount()
    {
        return $this->getStatement()->rowCount();
    }

    /**
     * @return mixed
     */
    public function columnCount()
    {
        return $this->getStatement()->columnCount();
    }

    /**
     * @return mixed
     */
    public function lastInsertId()
    {
        return $this->link->lastInsertId();
    }

    /**
     * @return string
     */
    public function errorCode()
    {
        return $this->link->errorCode();
    }

    /**
     * @return string
     */
    public function errorMessage()
    {
        $errorInfo = $this->link->errorInfo();
        return sprintf(self::ERROR_MESSAGE_PATTERN, $errorInfo[2], $this->errorCode(), 'pdo');
    }

    /**
     * @param string $string String
     * @return string
     */
    public function escape($string)
    {
        return $this->link->quote($string);
    }

}

/**
 * Class Bridge_Library_Fs_Image
 */
class Bridge_Library_Fs_Image
{

    /**
     * @var bool|resource
     */
    protected $image = false;

    /**
     * @var int
     */
    protected $type;

    /**
     * @var int
     */
    protected $compression = 85;

    /**
     * @param mixed $image  Image
     * @param null  $width  Width
     * @param null  $height Height
     * @return $this
     * @throws Bridge_Exception
     */
    public function resize($image, $width, $height = null)
    {
        if (false !== ($this->image = $this->download($image))) {
            $originalWidth = imagesx($this->image);
            $originalHeight = imagesy($this->image);

            if (($height && $originalWidth != $width) || ($height && $originalHeight != $height)) {
                if (null === $height) {
                    if ($originalWidth < $originalHeight) {
                        $height = $width;
                        $width = $height / $originalHeight * $originalWidth;
                    } else {
                        $height = $width / $originalWidth * $originalHeight;
                    }
                }

                $scaleWidth = $width / $originalWidth;
                $scaleHeight = $height / $originalHeight;

                $nextWidth = $width;
                $nextHeight = $height;

                if ($scaleWidth < 1 || $scaleHeight < 1) {
                    if ($scaleWidth > $scaleHeight) {
                        $nextHeight = $height;
                        $nextWidth = intval(($originalWidth * $nextHeight) / $originalHeight);
                    } else {
                        $nextHeight = intval($originalHeight * $width / $originalWidth);
                    }
                }

                $borderWidth = intval(($width - $nextWidth) / 2);
                $borderHeight = intval(($height - $nextHeight) / 2);

                $destinationImage = imagecreatetruecolor($width, $height);

                imagefill($destinationImage, 0, 0, imagecolorallocate($destinationImage, 255, 255, 255));

                imagecopyresampled(
                    $destinationImage,
                    $this->image,
                    $borderWidth,
                    $borderHeight,
                    0,
                    0,
                    $nextWidth,
                    $nextHeight,
                    $originalWidth,
                    $originalHeight
                );

                imagecolortransparent($destinationImage, imagecolorallocate($destinationImage, 255, 255, 255));

                imagedestroy($this->image);
                $this->image = $destinationImage;
            }
        }

        return $this;
    }

    /**
     * @param string $filename Filename
     * @param null   $type     Type
     * @return bool
     */
    public function save($filename, $type = null)
    {
        $result = false;

        switch ($type === null ? $this->type : $type) {
            case IMAGETYPE_JPEG:
                $result = @imagejpeg($this->image, $filename, $this->compression);
                break;
            case IMAGETYPE_GIF:
                $result = @imagegif($this->image, $filename);
                break;
            case IMAGETYPE_PNG:
                $result = @imagepng($this->image, $filename);
                break;
        }

        imagedestroy($this->image);

        return $result;
    }

    /**
     * @param int $compression Compression
     * @return void
     */
    public function setCompression($compression)
    {
        $this->compression = $compression;
    }

    /**
     * @param mixed $path Path
     * @return bool|resource
     */
    protected function download($path)
    {
        $info = @getimagesize($path);

        if (false === $info) {
            return false;
        }

        switch ($this->type = $info[2]) {
            case IMAGETYPE_JPEG:
                return imagecreatefromjpeg($path);
            case IMAGETYPE_GIF:
                return imagecreatefromgif($path);
            case IMAGETYPE_PNG:
                return imagecreatefrompng($path);
            default:
                return false;
        }
    }

}

/**
 * Class Cms_Module_Abstract
 */
abstract class Bridge_Module_Abstract
{

    /**
     * @var Bridge_Library_Response
     */
    protected $response;

    /**
     * @var array
     */
    protected $params = array();

    /**
     * Bridge_Module_Abstract constructor.
     * @param array $params Parrams
     */
    public function __construct(array $params)
    {
        $this->response = new Bridge_Library_Response();
        $this->params   = $params;
    }

    /**
     * @return Bridge_Library_Response
     */
    public function getResponse()
    {
        return $this->response;
    }

    /**
     * @param mixed $name    Name
     * @param null  $default Default
     * @return mixed|null
     */
    public function getParam($name, $default = null)
    {
        if (isset($this->params[$name])) {
            return $this->params[$name];
        }

        return $default;
    }

    /**
     * @return mixed
     */
    abstract public function run();

}

/**
 * Class Bridge_Module_Info
 */
class Bridge_Module_Info extends Bridge_Module_Abstract
{

    /**
     * Request params constants
     */
    const PARAM_PLATFORM        = 'platform';
    const PARAM_PHP_INI_OPTIONS = 'php_ini_options';

    /**
     * Main module function
     * @return void
     */
    public function run()
    {
        $platform = Bridge_Library_System::getInstance()->factoryPlatform($this->getParam(self::PARAM_PLATFORM));
        $platform->setPhpIniOptions($this->getParam(self::PARAM_PHP_INI_OPTIONS, array()));
        $this->getResponse()->add($platform->toArray());
    }

}

/**
 * Class Bridge_Module_Fs
 */
class Bridge_Module_Fs extends Bridge_Module_Abstract
{

    /**
     * Param constants
     */
    const PARAM_FILES     = 'files';
    const PARAM_OPERATION = 'operation';
    const PARAM_PLATFORM  = 'platform';
    const PARAM_FILE_NAME = 'name';

    /**
     * Result keys constant
     */
    const RESULT_STATUS  = 'status';
    const RESULT_MESSAGE = 'message';
    const RESULT_DATA    = 'data';

    /**
     * File info offsets
     */
    const FILE_SOURCE = 'source';
    const FILE_TARGET = 'target';
    const FILE_WIDTH  = 'width';
    const FILE_HEIGHT = 'height';
    const FILE_NAME   = 'name';

    /**
     * Operations constants
     */
    const OPERATION_CREATE           = 'create';
    const OPERATION_COPY             = 'copy';
    const OPERATION_DELETE           = 'delete';
    const OPERATION_READ             = 'read';
    const OPERATION_DOWNLOAD         = 'download';
    const OPERATION_DOWNLOAD_FROM_DB = 'downloadFromDb';
    const OPERATION_WRITE            = 'write';
    const OPERATION_CHMOD            = 'chmod';
    const OPERATION_LIST             = 'list';
    const OPERATION_CLEAR_CACHE      = 'clearCache';

    /**
     * @var array
     */
    protected $result = array();

    /**
     * @var array
     */
    protected $files = array();

    /**
     * @var null|Bridge_Library_Fs_Image
     */
    protected $image = null;

    /**
     * Main module method
     * @return void
     */
    public function run()
    {
        $operation = $this->getParam(self::PARAM_OPERATION);

        $this->files = $this->getParam(self::PARAM_FILES, array());

        if (null !== $operation && method_exists($this, $operation = 'operation' . ucfirst($operation))) {
            switch ($this->getParam(self::PARAM_OPERATION)) {
                case self::OPERATION_CLEAR_CACHE:
                    $this->getResponse()->add(self::RESULT_STATUS, $this->operationClearCache());
                    break;
                case self::OPERATION_DOWNLOAD_FROM_DB:
                    $this->operationDownloadFromDb();
                    break;
                default:
                    while (false !== current($this->files)) {
                        try {
                            $this->getResponse()->add(key($this->files), call_user_func_array(array($this, $operation), array()));
                        } catch (Exception $exception) {
                            $this->getResponse()->add(key($this->files), array(self::RESULT_STATUS => false));
                        }

                        next($this->files);
                    }
            }
        } else {
            $this->throwFs('Operation \'' . $operation . '\' is not valid');
        }
    }

    /**
     * @return array
     */
    public function operationCreate()
    {
        $result = array(self::RESULT_STATUS  => @touch($this->getSource()));

        if (false === $result[self::RESULT_STATUS]) {
            $result[self::RESULT_MESSAGE] = 'Can not create ' . $this->getSource();
        }

        return $result;
    }

    /**
     * @return array
     */
    public function operationCopy()
    {
        if (null == $this->getHeight() && null == $this->getWidth()) {
            $status = @copy($this->getSource(), $this->getTarget());
        } else {
            $status = $this->getImage()
                ->resize($this->getSource(), $this->getWidth(), $this->getHeight())
                ->save($this->getTarget());
        }

        if (false === $status) {
            if ($file = @file_get_contents($this->getSource())) {
                $status = (bool)file_put_contents($this->getTarget(), $file);
            } else {
                $status = $this->copyViaCurl($this->getSource(), $this->getTarget());
            }
        }

        $result = array(self::RESULT_STATUS => $status);
        if (false === $status) {
            $result[self::RESULT_MESSAGE] = 'Can not copy ' . $this->getSource() . ' to ' . $this->getTarget();
        }

        return $result;
    }

    /**
     * @param string $sourceUrl  source Url
     * @param string $targetPath target Url
     * @return bool
     */
    protected function copyViaCurl($sourceUrl, $targetPath)
    {
        if (false == function_exists('curl_version')) {
            return false;
        }

        $ch = curl_init();
        curl_setopt($ch, CURLOPT_REFERER, parse_url($sourceUrl, PHP_URL_HOST));
        curl_setopt($ch, CURLOPT_URL, $sourceUrl);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_FOLLOWLOCATION, true);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
        curl_setopt($ch, CURLOPT_USERAGENT, 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.96 Safari/537.36');

        $body = curl_exec($ch);
        if (curl_errno($ch) || false == in_array(curl_getinfo($ch, CURLINFO_HTTP_CODE), array(200, 304))) {
            return false;
        }

        $fileHandle = @fopen($targetPath, 'w');
        $result = false;
        if ($body && $fileHandle) {
            $result = fwrite($fileHandle, $body);
            fclose($fileHandle);
        }

        return (bool)$result;
    }

    /**
     * @return array
     */
    public function operationDelete()
    {
        $result = array(self::RESULT_STATUS  => @unlink($this->getSource()));

        if (false === $result[self::RESULT_STATUS]) {
            $result[self::RESULT_MESSAGE] = 'Can not delete ' . $this->getSource();
        }

        return $result;
    }

    /**
     * @return array
     */
    public function operationRead()
    {
        $fileContents = @file_get_contents($this->getSource());

        $result = array(
            self::RESULT_STATUS  => (bool)$fileContents
        );

        if (false === $result[self::RESULT_STATUS]) {
            $result[self::RESULT_MESSAGE] = 'Can not read ' . $this->getSource();
        } else {
            $result[self::RESULT_DATA] = $fileContents;
        }

        return $result;
    }

    /**
     * @return void
     */
    public function operationDownload()
    {
        $files[] = $this->getSource();
        $files[] = '..' . DIRECTORY_SEPARATOR . trim($files[0], DIRECTORY_SEPARATOR);
        foreach ($files as $file) {
            if (file_exists($file)) {
                $fileName = $this->getParam(self::FILE_NAME);
                $fileName = $fileName ? $fileName : basename($file);

                header('Content-Type: application/octet-stream');
                header("Content-Disposition: attachment; filename=\"$fileName\"");
                header('Expires: 0');
                header('Cache-Control: must-revalidate');
                header('Pragma: public');
                header('Content-Length: ' . filesize($file));
                if (@readfile($file) === false) {
                    $fileHandler = @fopen($file, 'rb');
                    if ($fileHandler !== false) {
                        while (!feof($fileHandler)) {
                            echo fread($fileHandler, 8192);
                        }

                        fclose($fileHandler);
                    } else {
                        readfile($file); // try again and show error message on failure
                    }
                }

                exit;
            }
        }

        http_response_code(404);
        exit;
    }

    /**
     * @return void
     */
    public function operationDownloadFromDb()
    {
        $moduleDB = new Bridge_Module_Db($this->params);
        $result = $moduleDB->execQuery();
        if (false == empty($result[Bridge_Module_Db::RESULT_DATA])) {
            $row = reset($result[Bridge_Module_Db::RESULT_DATA]);
            $file = isset($row[self::FILE_SOURCE]) ? $row[self::FILE_SOURCE] : reset($row);
            $fileName = $this->getParam(self::FILE_NAME);
            $fileName = $fileName ? $fileName : (isset($row[self::FILE_NAME]) ? $row[self::FILE_NAME] : 'file');

            header('Content-Type: application/octet-stream');
            header("Content-Disposition: attachment; filename=\"$fileName\"");
            header('Expires: 0');
            header('Cache-Control: must-revalidate');
            header('Pragma: public');
            header('Content-Length: ' . strlen($file));
            echo $file;
            exit;
        }

        http_response_code(404);
        exit;
    }

    /**
     * @return array
     */
    public function operationWrite()
    {
        $result = array(
            self::RESULT_STATUS  => (bool)@file_put_contents($this->getSource(), $this->getTarget())
        );

        if (false === $result[self::RESULT_STATUS]) {
            $result[self::RESULT_MESSAGE] = 'Can not write contents to ' . $this->getSource();
        }

        return $result;
    }

    /**
     * @return array
     */
    public function operationChmod()
    {
        $status = true;

        if (is_dir($this->getSource())) {
            $handle = opendir($this->getSource());

            while ($file = readdir($handle)) {
                if (($file === '.') || ($file === '..')) {
                    continue;
                }

                $file = $this->getSource() . DIRECTORY_SEPARATOR . $file;

                if (is_dir($file)) {
                    if (false === @chmod($file, $this->getTarget())) {
                        $status = false;
                    }
                }
            }
        } else {
            $status = @chmod($this->getSource(), $this->getTarget());
        }

        $result = array(
            self::RESULT_STATUS  => $status
        );

        if (false === $status) {
            $resourceName = @is_dir($this->getSource()) ? 'directory' : 'file';
            $result[self::RESULT_MESSAGE] = 'Can not chmod ' . $resourceName . ' ' . $this->getSource();
        }

        return $result;
    }

    /**
     * @return array
     */
    public function operationList()
    {
        $list = @scandir($this->getSource());

        $result = array(
            self::RESULT_STATUS  => (bool)$list
        );

        if (false === $list) {
            $result[self::RESULT_MESSAGE] = 'Can not view list for ' . $this->getSource();
        } else {
            $result[self::RESULT_DATA] = $list;
        }

        return $result;
    }

    /**
     * @param mixed $message Message
     * @throws Bridge_Exception
     * @return void
     */
    protected function throwFs($message)
    {
        throw new Bridge_Exception($message, Bridge_Exception::ERROR_FS_ERROR);
    }

    /**
     * @return string
     */
    protected function getSource()
    {
        $current = current($this->files);

        if (false === isset($current[self::FILE_SOURCE])) {
            $this->throwFs('Source file is not set');
        }

        return $current[self::FILE_SOURCE];
    }

    /**
     * @return string
     */
    protected function getTarget()
    {
        $current = current($this->files);

        if (false === isset($current[self::FILE_TARGET])) {
            $this->throwFs('Target file is not set');
        }

        $path = $current[self::FILE_TARGET];
        if (strpos($path, '/') !== 0 || $this->checkLocalFilePath($path) == false) {
            $path = '..' . DIRECTORY_SEPARATOR . trim($current[self::FILE_TARGET], '/');
            $this->checkLocalFilePath($path);
        }

        return $path;
    }

    /**
     * @param string $path path
     * @return bool
     */
    protected function checkLocalFilePath($path)
    {
        $parts = explode(DIRECTORY_SEPARATOR, $path);
        array_pop($parts);
        if (false === empty($parts)) {
            $path = implode(DIRECTORY_SEPARATOR, $parts);
            if (false == is_dir($path)) {
                if (@mkdir($path, 0777, true)) {
                    return @chmod($path, 0777);
                }

                return false;
            }
        }

        return true;
    }

    /**
     * @return null|int
     */
    protected function getWidth()
    {
        $current = current($this->files);

        if (true === isset($current[self::FILE_WIDTH])) {
            return $current[self::FILE_WIDTH];
        }

        return null;
    }

    /**
     * @return null|int
     */
    protected function getHeight()
    {
        $current = current($this->files);

        if (true === isset($current[self::FILE_HEIGHT])) {
            return $current[self::FILE_HEIGHT];
        }

        return null;
    }

    /**
     * @return Bridge_Library_Fs_Image
     */
    protected function getImage()
    {
        if (null === $this->image) {
            $this->image = new Bridge_Library_Fs_Image();
        }

        return $this->image;
    }

    /**
     * @return bool
     */
    public function operationClearCache()
    {
        $platform = Bridge_Library_System::getInstance()->factoryPlatform($this->getParam(self::PARAM_PLATFORM));

        return $platform->clearCache();
    }

}

/**
 * Class Bridge_Module_Db
 */
class Bridge_Module_Db extends Bridge_Module_Abstract
{

    /**
     * Param keys constants
     */
    const PARAM_PLATFORM = 'platform';
    const PARAM_SQL      = 'sql';
    const PARAM_MODE     = 'mode';

    /**
     * Define result constants
     */
    const RESULT_DATA           = 'data';
    const RESULT_LAST_INSERT_ID = 'last_insert_id';
    const RESULT_AFFECTED_ROWS  = 'affected_rows';
    const RESULT_ROW_COUNT      = 'row_count';
    const RESULT_COLUMN_COUNT   = 'column_count';
    const RESULT_ERROR_CODE     = 'error_code';
    const RESULT_ERROR_MESSAGE  = 'error_message';

    /**
     * @var Bridge_Library_Db_Abstract
     */
    static private $db = null;

    /**
     * @throws Bridge_Exception
     * @return void
     */
    public function run()
    {
        $platform = Bridge_Library_System::getInstance()->factoryPlatform($this->getParam(self::PARAM_PLATFORM));

        if (null === ($sql = $this->getParam(self::PARAM_SQL))) {
            throw new Bridge_Exception('Empty query can\'t be passed', Bridge_Exception::ERROR_DB_QUERY_INVALID);
        }

        $mode = $this->getParam(self::PARAM_MODE, Bridge_Library_Db_Abstract::SQL_MODE_FETCH_ASSOC);

        $db = self::connect($platform);
        $db->query($sql);

        $this->getResponse()->add(
            array(
                self::RESULT_DATA           => $db->fetch($mode),
                self::RESULT_AFFECTED_ROWS  => $db->affectedRows(),
                self::RESULT_LAST_INSERT_ID => $db->lastInsertId(),
                self::RESULT_ROW_COUNT      => $db->rowsCount(),
                self::RESULT_COLUMN_COUNT   => $db->columnCount(),
                self::RESULT_ERROR_CODE     => $db->errorCode(),
                self::RESULT_ERROR_MESSAGE  => $db->errorMessage(),
            )
        );
    }

    /**
     * @param string $query query
     *
     * @return array
     * @throws Bridge_Exception
     */
    public function execQuery($query = null)
    {
        if (null == $query && (null === ($query = $this->getParam(self::PARAM_SQL)))) {
            throw new Bridge_Exception('Empty query can\'t be passed', Bridge_Exception::ERROR_DB_QUERY_INVALID);
        }

        $platform = Bridge_Library_System::getInstance()->factoryPlatform($this->getParam(self::PARAM_PLATFORM));
        $mode = $this->getParam(self::PARAM_MODE, Bridge_Library_Db_Abstract::SQL_MODE_FETCH_ASSOC);

        $db = self::connect($platform);
        $db->query($query);

        return array(
            self::RESULT_DATA           => $db->fetch($mode),
            self::RESULT_AFFECTED_ROWS  => $db->affectedRows(),
            self::RESULT_LAST_INSERT_ID => $db->lastInsertId(),
            self::RESULT_ROW_COUNT      => $db->rowsCount(),
            self::RESULT_COLUMN_COUNT   => $db->columnCount(),
            self::RESULT_ERROR_CODE     => $db->errorCode(),
            self::RESULT_ERROR_MESSAGE  => $db->errorMessage(),
        );
    }

    /**
     * @param Bridge_Platform_Abstract $platform Platform
     * @return Bridge_Library_Db_Abstract|mixed
     * @throws Bridge_Exception
     */
    public static function connect(Bridge_Platform_Abstract $platform = null)
    {
        if (false === (self::$db instanceof Bridge_Library_Db_Abstract)) {
            if (null === $platform) {
                throw new Bridge_Exception('Credentials not set', Bridge_Exception::ERROR_DB_CONNECT);
            }

            $adapterPrefix = 'Bridge_Library_Db_';

            switch (true) {
                case true === class_exists('mysqli'):
                    $adapterName = 'Mysqli';
                    break;
                case true === function_exists('mysql_connect'):
                    $adapterName = 'Mysql';
                    break;
                case true === class_exists('PDO'):
                    $adapterName = 'Pdo';
                    break;
                default:
                    throw new Bridge_Exception('Cannot find MYSQL Library', Bridge_Exception::ERROR_DB_CONNECT);
            }

            $adapterClass = $adapterPrefix . $adapterName;

            if (false === class_exists($adapterClass)) {
                throw new Bridge_Exception(
                    'Cannot find ' .
                    $adapterName . ' database adapter',
                    Bridge_Exception::ERROR_DB_CONNECT
                );
            }

            self::$db = new $adapterClass($platform->database());
            try {
                self::$db->preConfig();
            } catch (Exception $exception) {}
        }

        return self::$db;
    }

    /**
     * @param Bridge_Platform_Abstract $platform CMS platform
     * @return string
     * @throws Bridge_Exception
     */
    public static function getVersion(Bridge_Platform_Abstract $platform)
    {
        try {
            $db = self::connect($platform);
            $response = $db->query(sprintf('SELECT VERSION() as %s', Bridge_Platform_Abstract::DATABASE_VERSION))->fetch();
        } catch (Exception $exception) {
            throw new Bridge_Exception(
                'Cannot connect to database',
                Bridge_Exception::ERROR_DB_CONNECT
            );
        }

        return $response[0][Bridge_Platform_Abstract::DATABASE_VERSION];
    }

}

/**
 * Class Bridge_Module_Cms_Abstract
 * @method   Bridge_Platform_Abstract|array|string database (string $key   = null, string $value = null)
 * @method   Bridge_Platform_Abstract|array|string files    (string $key   = null, string $value = null)
 * @method   Bridge_Platform_Abstract|array|string parent   (string $key   = null, string $value = null)
 * @method   Bridge_Platform_Abstract|string       version  (string $value = null)
 * @method   Bridge_Platform_Abstract|string       type     (string $value = null)
 */
abstract class Bridge_Platform_Abstract
{

    /**
     * Bridge properties keys constants
     */
    const SECTION_BRIDGE = 'bridge';
    const BRIDGE_VERSION = 'version';
    const BRIDGE_KEY     = 'key';
    const BRIDGE_TYPE    = 'type';

    /**
     * Database properties keys constants
     */
    const SECTION_DATABASE  = 'database';
    const DATABASE_HOST     = 'host';
    const DATABASE_USER     = 'user';
    const DATABASE_PASSWORD = 'password';
    const DATABASE_DATABASE = 'database';
    const DATABASE_PORT     = 'port';
    const DATABASE_SOCKET   = 'socket';
    const DATABASE_PREFIX   = 'prefix';
    const DATABASE_CHARSET  = 'charset';
    const DATABASE_VERSION  = 'version';

    /**
     * PHP properties keys constants
     */
    const SECTION_PHP = 'php';
    const PHP_INI     = 'ini';
    const PHP_VERSION = 'version';

    /**
     * Platform properties keys constants
     */
    const SECTION_PLATFORM              = 'platform';
    const SECTION_PARENT_PLATFORM       = 'parent_platform';
    const PLATFORM_TYPE                 = 'type';
    const PLATFORM_VERSION              = 'version';
    const PLATFORM_IMAGES_PATH          = 'images_path';
    const PLATFORM_IMAGES_WRITABLE      = 'images_writable';
    const PLATFORM_ATTACHMENTS_PATH     = 'attachments_path';
    const PLATFORM_ATTACHMENTS_WRITABLE = 'attachments_writable';

    /**
     * @var array
     */
    protected $original = array();

    /**
     * @var array
     */
    protected $patterns = array(
        // Regular expression for variables detection
        '/(?:const|(?:protected|private|public|var)\$|\$)(\w+?)=(?!=|\$|&)[\'"]?([^\)]*?)[\'"]?;/i',
        '/(?:\$)(\w+?(?:\[[\'"]\w+?[\'"]\])+)=(?!=|\$|&)[\'"]?([^\)]*?)[\'"]?;/i',
        // Regular expression for defines detection
        '/define\([\'"]?(.*?)[\'"]?,[\'"]?(.*?)[\'"]?\);/i',
        '/[\'"]?(server(?:name)?|host(?:name)?|database|name|user(?:name)?|pass(?:word)?|port|(?:table_)?prefix|version(?:_id)?)[\'"]?=>[\'"](.*?)[\'"],?/im'
    );

    /**
     * @var array
     */
    protected $phpIniOptions = array(
        'post_max_size'
    );

    /**
     * @var array
     */
    private static $supportedPlatforms = array(
        'WordPress',
        'Joomla',
        'Kunena',
        'Drupal',
        'eZPublish',
        'MediaWiki',
        'B2Evolution',
        'Concrete5',
        'Dle',
        'E107',
        'IPBoard',
        'MyBB',
        'SMF',
        'Typo3',
        'SilverStripe',
        'VBulletin',
        'phpBB',
        'ExpressionEngine',
    );

    /**
     * @var array
     */
    protected $database = array(
        self::DATABASE_HOST     => 'localhost',
        self::DATABASE_USER     => 'root',
        self::DATABASE_PASSWORD => '',
        self::DATABASE_DATABASE => '',
        self::DATABASE_PORT     => null,
        self::DATABASE_SOCKET   => null,
        self::DATABASE_PREFIX   => '',
        self::DATABASE_CHARSET  => ''
    );

    /**
     * @var string
     */
    protected $version = '1.0';

    /**
     * @var string
     */
    protected $type = '';

    /**
     * @var array
     */
    protected $files = array(
        self::PLATFORM_IMAGES_PATH          => '',
        self::PLATFORM_IMAGES_WRITABLE      => false,
        self::PLATFORM_ATTACHMENTS_PATH     => '',
        self::PLATFORM_ATTACHMENTS_WRITABLE => false
    );

    /**
     * @var array
     */
    protected $parent = array(
        self::PLATFORM_TYPE                 => null,
        self::PLATFORM_VERSION              => null,
        self::PLATFORM_IMAGES_PATH          => null,
        self::PLATFORM_IMAGES_WRITABLE      => false,
        self::PLATFORM_ATTACHMENTS_PATH     => null,
        self::PLATFORM_ATTACHMENTS_WRITABLE => false
    );

    /**
     * @param mixed $method    Method
     * @param array $arguments Arguments
     * @return string|Bridge_Platform_Abstract
     * @throws Bridge_Exception
     */
    public function __call($method, array $arguments)
    {
        if (false === property_exists($this, $method)) {
            throw new Bridge_Exception('Property ' . $method . ' not found');
        }

        $key = isset($arguments[0]) ? $arguments[0] : null;
        $value = isset($arguments[1]) ? $arguments[1] : null;

        switch (true) {
            case null === $key:
                return $this->$method;
            case false === array_key_exists(1, $arguments) && true === is_array($this->$method):
                return $this->{$method}[$key];
            case false === is_array($this->$method):
                $this->$method = $key;
                return $this;
            case true === is_array($this->$method):
                $this->{$method}[$key] = $value;
                return $this;
            default:
                return $this;
        }
    }

    /**
     * @param string $host Host
     * @return self
     */
    public function setDatabaseHost($host)
    {
        $this->database(self::DATABASE_HOST, 'localhost');

        $hostConfig = explode(':', $host);
        $this->database(strpos($hostConfig[0], '/') === 0 ? self::DATABASE_SOCKET : self::DATABASE_HOST, $hostConfig[0]);
        if (isset($hostConfig[1])) {
            $this->database(strpos($hostConfig[1], '/') === 0 ? self::DATABASE_SOCKET : self::DATABASE_PORT, $hostConfig[1]);
        }

        return $this;
    }

    /**
     * @return array
     */
    public static function platformList()
    {
        return self::$supportedPlatforms;
    }

    /**
     * @return array
     */
    public function getPhpIniOptions()
    {
        $options = array();
        foreach ($this->phpIniOptions as $phpIniOption) {
            $options[$phpIniOption] = ini_get((string)$phpIniOption);
        }

        return $options;
    }

    /**
     * @param array $options Options
     * @param bool  $replace Replace
     * @return void
     */
    public function setPhpIniOptions($options, $replace = false)
    {
        $this->phpIniOptions = $replace ? (array)$options : array_merge((array)$options, $this->phpIniOptions);
    }

    /**
     * @return $this
     */
    abstract public function getConfiguration();

    /**
     * @return bool|array
     */
    public function valid()
    {
        $valid = false;

        foreach ($this->original as $key => &$config) {
            foreach ($config as &$file) {
                $valid = file_exists(CMS_PATH . $file) && false !== ($file = $this->readFile($file));
            }

            if (true === $valid) {
                return $this->parseOriginalFile($this->original[$key]);
            }
        }

        return $valid;
    }

    /**
     * @param mixed $file File
     * @return string
     */
    protected function readFile($file)
    {
        $tokens = token_get_all(file_get_contents(CMS_PATH . $file));

        $blockedTokens = array(
            T_OPEN_TAG,
            T_CLOSE_TAG,
            T_COMMENT,
            T_DOC_COMMENT,
            T_WHITESPACE
        );

        foreach ($tokens as $key => &$token) {
            if (is_array($token)) {
                if (in_array($token[0], $blockedTokens)) {
                    unset($tokens[$key]);
                } else {
                    $token = $token[1];
                }
            }
        }

        return implode('', $tokens);
    }

    /**
     * @return array
     */
    protected function getPatterns()
    {
        return $this->patterns;
    }

    /**
     * @param mixed $files Files
     * @return array
     */
    protected function parseOriginalFile($files)
    {
        $this->original = array();
        foreach ($files as $content) {
            foreach ($this->getPatterns() as $pattern) {
                preg_match_all($pattern, $content, $variables);
                if (false == empty($variables[1]) || false == empty($variables[2])) {
                    $vars = array();
                    foreach ($variables[1] as $key => $varName) {
                        $varName = str_replace(array('"', "'"), '', $varName);
                        $vars[$varName] = $variables[2][$key];
                    }

                    $this->original = array_merge($this->original, $vars);
                }
            }
        }

        return $this->original;
    }

    /**
     * @return array
     */
    public function toArray()
    {
        $config = array(
            self::SECTION_BRIDGE => array(
                self::BRIDGE_KEY     => CMS2CMS_KEY,
                self::BRIDGE_TYPE    => CMS2CMS_BRIDGE_TYPE,
                self::BRIDGE_VERSION => CMS2CMS_VERSION
            ),
            self::SECTION_PHP => array(
                self::PHP_VERSION => phpversion(),
                self::PHP_INI     => $this->getPhpIniOptions()
            ),
            self::SECTION_DATABASE    => array(
                self::DATABASE_VERSION => Bridge_Module_Db::getVersion($this),
                self::DATABASE_PREFIX  => $this->database(self::DATABASE_PREFIX),
                self::DATABASE_CHARSET => $this->database(self::DATABASE_CHARSET)
            ),
            self::SECTION_PLATFORM => array(
                self::PLATFORM_TYPE                 => $this->type(),
                self::PLATFORM_VERSION              => $this->version(),
                self::PLATFORM_IMAGES_PATH          => $this->files(self::PLATFORM_IMAGES_PATH),
                self::PLATFORM_IMAGES_WRITABLE      => $this->files(self::PLATFORM_IMAGES_WRITABLE),
                self::PLATFORM_ATTACHMENTS_PATH     => $this->files(self::PLATFORM_ATTACHMENTS_PATH),
                self::PLATFORM_ATTACHMENTS_WRITABLE => $this->files(self::PLATFORM_ATTACHMENTS_WRITABLE)
            )
        );

        if ($this->parent(self::PLATFORM_TYPE)) {
            $config[self::SECTION_PARENT_PLATFORM] = array(
                self::PLATFORM_TYPE                 => $this->parent(self::PLATFORM_TYPE),
                self::PLATFORM_VERSION              => $this->parent(self::PLATFORM_VERSION),
                self::PLATFORM_IMAGES_PATH          => $this->parent(self::PLATFORM_IMAGES_PATH),
                self::PLATFORM_IMAGES_WRITABLE      => $this->parent(self::PLATFORM_IMAGES_WRITABLE),
                self::PLATFORM_ATTACHMENTS_PATH     => $this->parent(self::PLATFORM_ATTACHMENTS_PATH),
                self::PLATFORM_ATTACHMENTS_WRITABLE => $this->parent(self::PLATFORM_ATTACHMENTS_WRITABLE),
            );
        }

        return $config;
    }

    /**
     * @param string|array $name       Name
     * @param null         $default    Default
     * @param bool         $allowEmpty Allow empty
     * @return mixed|null
     */
    public function getConfigVar($name, $default = null, $allowEmpty = true)
    {
        $names = is_array($name) ? $name : array($name);
        foreach ($names as $name) {
            if (isset($this->original[$name]) && ($allowEmpty || $this->original[$name])) {
                return $this->original[$name];
            }
        }

        return $default;
    }

    /**
     * @return bool
     */
    public function clearCache()
    {
        return true;
    }

}

/**
 * Class Bridge_Platform_WordPress
 */
class Bridge_Platform_WordPress extends Bridge_Platform_Abstract
{

    /**
     * @var array
     */
    protected $original = array(
        array('/wp-config.php', '/wp-includes/version.php')
    );

    /**
     * @return $this
     * @throws Bridge_Exception
     */
    public function getConfiguration()
    {
        $this->type('WordPress')
            ->version($this->getConfigVar('wp_version'))
            ->setDatabaseHost($this->getConfigVar('DB_HOST'))
            ->database(self::DATABASE_USER, $this->getConfigVar('DB_USER'))
            ->database(self::DATABASE_PASSWORD, $this->getConfigVar('DB_PASSWORD'))
            ->database(self::DATABASE_DATABASE, $this->getConfigVar('DB_NAME'))
            ->database(self::DATABASE_PREFIX, $this->getConfigVar('table_prefix'))
            ->database(self::DATABASE_CHARSET, $this->getConfigVar('DB_CHARSET'))
            ->files(self::PLATFORM_IMAGES_PATH, is_dir('../wp-images') ? '/wp-images' : '/wp-content/uploads')
            ->files(self::PLATFORM_IMAGES_WRITABLE, is_writable('../wp-content/uploads') || is_writable('../wp-images'))
            ->files(self::PLATFORM_ATTACHMENTS_PATH, $this->files(self::PLATFORM_IMAGES_PATH) . '/attachments');

        return $this;
    }

}

/**
 * Class Bridge_Platform_Joomla
 */
class Bridge_Platform_Joomla extends Bridge_Platform_Abstract
{

    /**
     * @var array
     */
    protected $original = array(
        array('/configuration.php', '/includes/version.php'),
        array('/configuration.php', '/libraries/joomla/version.php'),
        array('/configuration.php', '/libraries/cms/version/version.php'),
        array('/configuration.php', '/libraries/src/Version.php'),
    );

    /**
     * @return array
     */
    public function getPatterns()
    {
        $this->patterns[] = '/\$(host|user|password|db|dbprefix).?=.*?\'(.*?)\';/im';
        return $this->patterns;
    }

    /**
     * @return $this
     * @throws Bridge_Exception
     */
    public function getConfiguration()
    {
        $this->type('Joomla')
            ->version($this->getConfigVar('RELEASE') . '.' . $this->getConfigVar('DEV_LEVEL'))
            ->setDatabaseHost($this->getConfigVar('host'))
            ->database(self::DATABASE_USER, $this->getConfigVar('user'))
            ->database(self::DATABASE_PASSWORD, $this->getConfigVar('password'))
            ->database(self::DATABASE_DATABASE, $this->getConfigVar('db'))
            ->database(self::DATABASE_PREFIX, $this->getConfigVar('dbprefix'))
            ->database(self::DATABASE_CHARSET, '')
            ->files(self::PLATFORM_IMAGES_PATH, '/images')
            ->files(self::PLATFORM_IMAGES_WRITABLE, is_writable('../images'))
            ->files(self::PLATFORM_ATTACHMENTS_PATH, '/images')
            ->files(self::PLATFORM_ATTACHMENTS_WRITABLE, is_writable('../images'));

        return $this;
    }

}

/**
 * Class Bridge_Platform_Kunena
 */
class Bridge_Platform_Kunena extends Bridge_Platform_Joomla
{

    /**
     * @return $this
     * @throws Bridge_Exception
     */
    public function getConfiguration()
    {
        parent::getConfiguration();
        $dir = is_dir('../media/kunena') ? '/media/kunena' : '/images/fbfiles';
        $this->type('Kunena')
            ->files(self::PLATFORM_IMAGES_PATH, $dir)
            ->files(self::PLATFORM_IMAGES_WRITABLE, is_writable('..' . $dir))
            ->files(self::PLATFORM_ATTACHMENTS_PATH,  $dir .'/attachments')
            ->files(self::PLATFORM_ATTACHMENTS_WRITABLE, is_writable('..' . $dir . '/attachments'));

        return $this;
    }

}

/**
 * Class Bridge_Platform_eZPublish
 */
class Bridge_Platform_eZPublish extends Bridge_Platform_Abstract
{

    /**
     * Bridge_Platform_eZPublish constructor.
     */
    public function __construct()
    {
        $this->original = array($this->detectConfigurationPath());
    }

    /**
     * @var array
     */
    protected $original = array(
        array('/ezpublish_legacy/settings/site.ini'),
    );

    /**
     * @var array
     */
    protected $ezAccess = array(
        '/settings/override/site.ini.append.php',
        '/ezpublish_legacy/settings/override/site.ini.append.php'
    );

    /**
     * @return array
     */
    public function getPatterns()
    {
        $this->patterns[] = '/(Server|User|Password|Database|Charset)=(.*)/im';

        return $this->patterns;
    }

    /**
     * @return $this
     * @throws Bridge_Exception
     */
    public function getConfiguration()
    {
        $this
            ->type('eZPublish')
            ->version($this->getConfigVar($this->original['VERSION'], 4))
            ->setDatabaseHost($this->getConfigVar('Server'))
            ->database(self::DATABASE_USER, $this->getConfigVar('User'))
            ->database(self::DATABASE_PASSWORD, $this->getConfigVar('Password'))
            ->database(self::DATABASE_DATABASE, $this->getConfigVar('Database'))
            ->database(self::DATABASE_PREFIX, $this->getConfigVar(''))
            ->database(self::DATABASE_CHARSET, $this->getConfigVar('Charset'))
            ->files(self::PLATFORM_IMAGES_PATH, '');

        return $this;
    }

    /**
     * Parse connection from url
     * @return string
     */
    protected function detectConfigurationPath()
    {
        foreach ($this->ezAccess as $file) {
            $file = CMS_PATH . $file;
            if (true === file_exists($file)) {
                preg_match_all('/AvailableSiteAccessList\[\]=(.*)/im', file_get_contents($file), $variables);
                if (false == empty($variables[1][0])) {
                    if (true === file_exists(CMS_PATH . 'settings/siteaccess/' . $variables[1][0] . '/site.ini.append.php')) {
                        return array('settings/siteaccess/' . $variables[1][0] . '/site.ini.append.php');
                    }
                }
            }
        }

        return array('/settings/site.ini');
    }

    /**
     * @param mixed $file File
     * @return string
     */
    protected function readFile($file)
    {
        $tokens = token_get_all(file_get_contents(CMS_PATH . $file));

        $blockedTokens = array(
            T_OPEN_TAG,
            T_CLOSE_TAG,
            T_DOC_COMMENT,
            T_WHITESPACE
        );

        foreach ($tokens as $key => &$token) {
            if (is_array($token)) {
                if (in_array($token[0], $blockedTokens)) {
                    unset($tokens[$key]);
                } else {
                    $token = $token[1];
                }
            }
        }

        return implode('', $tokens);
    }

}

/**
 * Class Bridge_Platform_Drupal
 */
class Bridge_Platform_Drupal extends Bridge_Platform_Abstract
{

    /**
     * @var null
     */
    private $path = null;

    /**
     * @var array
     */
    protected $original = array(
        array('/sites/default/settings.php', '/core/lib/Drupal.php'),
        array('/includes/bootstrap.inc', '/modules/system/system.module', '/sites/default/settings.php'),
    );

    /**
     * Bridge_Platform_Drupal constructor.
     */
    public function __construct()
    {
        $this->detectConfigurationPath();
    }

    /**
     * @inheritdoc
     * @return array
     */
    public function getPatterns()
    {
        $this->patterns[] = '/[\'|\"]?(prefix)[\'|\"]\=\>([array\(|\[].*?[\)|\]])/im';
        return $this->patterns;
    }

    /**
     * @return $this
     * @throws Bridge_Exception
     */
    public function getConfiguration()
    {
        $this->parseMysqlUrl();

        $this->type('Drupal')
            ->version($this->getConfigVar('VERSION'))
            ->setDatabaseHost($this->getConfigVar('host'))
            ->database(self::DATABASE_USER, $this->getConfigVar('username'))
            ->database(self::DATABASE_PASSWORD, $this->getConfigVar('password'))
            ->database(self::DATABASE_DATABASE, $this->getConfigVar('database'))
            ->database(self::DATABASE_PREFIX, $this->getConfigVar('prefix'))
            ->database(self::DATABASE_CHARSET, '')
            ->files(self::PLATFORM_IMAGES_PATH, '/sites/' . $this->path . '/files')
            ->files(self::PLATFORM_IMAGES_WRITABLE, is_writable('../sites/' . $this->path . '/files'))
            ->files(self::PLATFORM_ATTACHMENTS_PATH, '/sites/' . $this->path . '/files')
            ->files(self::PLATFORM_ATTACHMENTS_WRITABLE, is_writable('../sites/' . $this->path . '/files'));

        return $this;
    }

    /**
     * Parse connection from url
     * @return void
     */
    protected function parseMysqlUrl()
    {
        if (true == isset($this->original['host'])) {
            return;
        }

        $original = parse_url($this->getConfigVar('db_url'));
        $this->original['host'] = urldecode($original['host']);
        $this->original['username'] = urldecode($original['user']);
        $this->original['password'] = isset($original['pass']) ? urldecode($original['pass']) : '';
        $this->original['database'] = str_replace('/', '', urldecode($original['path']));
        $this->original['prefix'] = $this->getConfigVar('db_prefix');
    }

    /**
     * @return null|string
     */
    private function detectConfigurationPath()
    {
        if (null === $this->path) {
            $this->path = 'default';
            if (false == file_exists(CMS_PATH . '/sites/sites.php')) {
                return $this->path;
            }

            $settings = glob(CMS_PATH . '/sites/*/settings.php');
            if (count($settings) == 1) {
                $this->path = str_replace(array(CMS_PATH . '/sites/', '/settings.php'), '', $settings[0]);
            } else {
                include CMS_PATH . '/sites/sites.php';

                if (!($scriptName = $_SERVER['SCRIPT_NAME'])) {
                    $scriptName = $_SERVER['SCRIPT_FILENAME'];
                }

                $scriptName = str_replace('cms2cms/bridge.php', '', $scriptName);

                $host = $_SERVER['HTTP_HOST'];
                if (false == strpos($host, ':')) {
                    $host .= ':' . $_SERVER['SERVER_PORT'];
                }

                $uri    = explode('/', $scriptName);
                $server = explode('.', implode('.', array_reverse(explode(':', rtrim($host, '.')))));
                for ($i = count($uri) - 1; $i > 0; $i--) {
                    for ($j = count($server); $j > 0; $j--) {
                        $dir = implode('.', array_slice($server, -$j)) . implode('.', array_slice($uri, 0, $i));
                        if (isset($sites[$dir]) && file_exists(CMS_PATH . '/sites/' . $sites[$dir] . '/settings.php')) {
                            $dir = $sites[$dir];
                        }

                        if (file_exists(CMS_PATH . '/sites/' . $dir . '/settings.php')) {
                            $this->path = $dir;
                            break(2);
                        }
                    }
                }
            }
        }

        foreach ($this->original as &$files) {
            foreach ($files as &$file) {
                $file = str_replace('/default/', '/' . $this->path . '/', $file);
            }
        }

        return $this->path;
    }

}

/**
 * Class Bridge_Platform_B2Evolution
 */
class Bridge_Platform_B2Evolution extends Bridge_Platform_Abstract
{

    /**
     * @var array
     */
    protected $original = array(
        array('/conf/_basic_config.php', '/conf/_application.php'),
    );

    /**
     * @return $this
     * @throws Bridge_Exception
     */
    public function getConfiguration()
    {
        $this->type('B2evolution')
            ->version($this->getConfigVar('app_version'))
            ->setDatabaseHost($this->getConfigVar('host'))
            ->database(self::DATABASE_USER, $this->getConfigVar('user'))
            ->database(self::DATABASE_PASSWORD, $this->getConfigVar('password'))
            ->database(self::DATABASE_DATABASE, $this->getConfigVar('name'))
            ->database(self::DATABASE_PREFIX, $this->getConfigVar('tableprefix'))
            ->database(self::DATABASE_CHARSET, '')
            ->files(self::PLATFORM_IMAGES_PATH, '/media')
            ->files(self::PLATFORM_IMAGES_WRITABLE, is_writable('../media'));

        return $this;
    }

}

/**
 * Class Bridge_Platform_Concrete5
 */
class Bridge_Platform_Concrete5 extends Bridge_Platform_Abstract
{

    /**
     * @var array
     */
    protected $original = array(
        array('/concrete/config/concrete.php', '/application/config/database.php'),
        array('/config/site.php', '/concrete/config/version.php'),
    );

    /**
     * @return $this
     * @throws Bridge_Exception
     */
    public function getConfiguration()
    {
        $this->type('Concrete5')
            ->version($this->getConfigVar(array('APP_VERSION', 'version')))
            ->setDatabaseHost($this->getConfigVar(array('DB_SERVER', 'server')))
            ->database(self::DATABASE_USER, $this->getConfigVar(array('DB_USERNAME', 'username')))
            ->database(self::DATABASE_PASSWORD, $this->getConfigVar(array('DB_PASSWORD', 'password')))
            ->database(self::DATABASE_DATABASE, $this->getConfigVar(array('DB_DATABASE', 'database')))
            ->database(self::DATABASE_PREFIX, '')
            ->database(self::DATABASE_CHARSET, '')
            ->files(self::PLATFORM_IMAGES_PATH, is_dir('../files') ? '/files' : '/application/files')
            ->files(self::PLATFORM_IMAGES_WRITABLE, is_writable('../files') || is_writable('../application/files'));

        return $this;
    }

}

/**
 * Class Bridge_Platform_Dle
 */
class Bridge_Platform_Dle extends Bridge_Platform_Abstract
{

    /**
     * @var array
     */
    protected $original = array(
        array('/engine/data/dbconfig.php', '/engine/data/config.php'),
    );

    /**
     * @return $this
     * @throws Bridge_Exception
     */
    public function getConfiguration()
    {
        $this->type('Dle')
            ->version($this->getConfigVar('version_id'))
            ->setDatabaseHost($this->getConfigVar('DBHOST'))
            ->database(self::DATABASE_USER, $this->getConfigVar('DBUSER'))
            ->database(self::DATABASE_PASSWORD, $this->getConfigVar('DBPASS'))
            ->database(self::DATABASE_DATABASE, $this->getConfigVar('DBNAME'))
            ->database(self::DATABASE_PREFIX, $this->getConfigVar('PREFIX'))
            ->database(self::DATABASE_CHARSET, '')
            ->files(self::PLATFORM_IMAGES_PATH, '/uploads')
            ->files(self::PLATFORM_IMAGES_WRITABLE, is_writable('../uploads'));

        return $this;
    }

}

/**
 * Class Bridge_Platform_Dle
 */
class Bridge_Platform_E107 extends Bridge_Platform_Abstract
{

    /**
     * @var array
     */
    protected $original = array(
        array('/e107_config.php', '/e107_admin/ver.php'),
    );

    /**
     * @return array
     */
    public function getPatterns()
    {
        $this->patterns[] = '/(e107_version).*[\'\"](.*)[\'\"]/im';
        return $this->patterns;
    }

    /**
     * @return $this
     * @throws Bridge_Exception
     */
    public function getConfiguration()
    {
        $this->type('E107')
            ->version($this->getConfigVar('e107_version'))
            ->setDatabaseHost($this->getConfigVar('mySQLserver'))
            ->database(self::DATABASE_USER, $this->getConfigVar('mySQLuser'))
            ->database(self::DATABASE_PASSWORD, $this->getConfigVar('mySQLpassword'))
            ->database(self::DATABASE_DATABASE, $this->getConfigVar('mySQLdefaultdb'))
            ->database(self::DATABASE_PREFIX, $this->getConfigVar('mySQLprefix'))
            ->database(self::DATABASE_CHARSET, '')
            ->files(self::PLATFORM_IMAGES_PATH, '/e107_images')
            ->files(self::PLATFORM_IMAGES_WRITABLE, is_writable('../e107_images'));

        return $this;
    }

}

/**
 * Class Bridge_Platform_IPBoard
 */
class Bridge_Platform_IPBoard extends Bridge_Platform_Abstract
{

    /**
     * @var array
     */
    protected $original = array(
        array('/conf_global.php'),
    );

    /**
     * @return array
     */
    public function getPatterns()
    {
        $this->patterns[] = '/[\'\"](sql_host|sql_user|sql_pass|sql_database|sql_tbl_prefix)[\'\"].*?[\'\"](.*?)[\'\"]/im';
        return $this->patterns;
    }

    /**
     * @return $this
     * @throws Bridge_Exception
     */
    public function getConfiguration()
    {
        $this->type('IPBoard')
            ->version('')
            ->setDatabaseHost($this->getConfigVar('sql_host'))
            ->database(self::DATABASE_USER, $this->getConfigVar('sql_user'))
            ->database(self::DATABASE_PASSWORD, $this->getConfigVar('sql_pass'))
            ->database(self::DATABASE_DATABASE, $this->getConfigVar('sql_database'))
            ->database(self::DATABASE_PREFIX, $this->getConfigVar('sql_tbl_prefix'))
            ->database(self::DATABASE_CHARSET, '')
            ->files(self::PLATFORM_IMAGES_PATH, '/uploads')
            ->files(self::PLATFORM_IMAGES_WRITABLE, is_writable('../uploads'));

        return $this;
    }

}

/**
 * Class Bridge_Platform_MyBB
 */
class Bridge_Platform_MyBB extends Bridge_Platform_Abstract
{

    /**
     * @var array
     */
    protected $original = array(
        array('/inc/config.php', '/inc/class_core.php'),
    );

    /**
     * @return $this
     * @throws Bridge_Exception
     */
    public function getConfiguration()
    {
        $this->type('MyBB')
            ->version($this->getConfigVar('version'))
            ->setDatabaseHost($this->getConfigVar('hostname'))
            ->database(self::DATABASE_USER, $this->getConfigVar('username'))
            ->database(self::DATABASE_PASSWORD, $this->getConfigVar('password'))
            ->database(self::DATABASE_DATABASE, $this->getConfigVar('database'))
            ->database(self::DATABASE_PREFIX, $this->getConfigVar('table_prefix'))
            ->database(self::DATABASE_CHARSET, '')
            ->files(self::PLATFORM_IMAGES_PATH, '/')
            ->files(self::PLATFORM_IMAGES_WRITABLE, is_writable('../uploads') || is_writable('../images'));

        return $this;
    }

}

/**
 * Class Bridge_Platform_SMF
 */
class Bridge_Platform_SMF extends Bridge_Platform_Abstract
{

    /**
     * @var array
     */
    protected $original = array(
        array('/Settings.php'),
    );

    /**
     * @return $this
     * @throws Bridge_Exception
     */
    public function getConfiguration()
    {
        $this->type('SMF')
            ->version('')
            ->setDatabaseHost($this->getConfigVar('db_server'))
            ->database(self::DATABASE_USER, $this->getConfigVar('db_user'))
            ->database(self::DATABASE_PASSWORD, $this->getConfigVar('db_passwd'))
            ->database(self::DATABASE_DATABASE, $this->getConfigVar('db_name'))
            ->database(self::DATABASE_PREFIX, $this->getConfigVar('db_prefix'))
            ->database(self::DATABASE_CHARSET, '')
            ->files(self::PLATFORM_IMAGES_PATH, '');

        return $this;
    }

}

/**
 * Class Bridge_Platform_TYPO3
 */
class Bridge_Platform_Typo3 extends Bridge_Platform_Abstract
{

    /**
     * @var array
     */
    protected $original = array(
        array('/t3lib/config_default.php', '/typo3conf/localconf.php'),
        array('/typo3/sysext/core/Classes/Core/SystemEnvironmentBuilder.php', '/typo3conf/LocalConfiguration.php' )
    );

    /**
     * @return array
     */
    public function getPatterns()
    {
        $this->patterns[] = '/[\'\"](host|user|password|dbname|port)[\'\"].*?[\'\"](.*?)[\'\"]/im';
        return $this->patterns;
    }

    /**
     * @return $this
     * @throws Bridge_Exception
     */
    public function getConfiguration()
    {
        $version = $this->getConfigVar(array('TYPO_VERSION', 'TYPO3_version'));
        if ((int)$version < 6) {
            $dir = is_dir('../uploads/pics') ? '/uploads/pics' : '/fileadmin';
        } else {
            $dir = is_dir('../fileadmin') ? '/fileadmin' : '/uploads/pics';
        }

        $this->type('Typo3')
            ->version($version)
            ->setDatabaseHost($this->getConfigVar(array('typo_db_host', 'host')))
            ->database(self::DATABASE_USER, $this->getConfigVar(array('typo_db_username', 'username', 'user')))
            ->database(self::DATABASE_PASSWORD, $this->getConfigVar(array('typo_db_password', 'password')))
            ->database(self::DATABASE_DATABASE, $this->getConfigVar(array('typo_db', 'database', 'dbname')))
            ->database(self::DATABASE_PREFIX, '')
            ->database(self::DATABASE_CHARSET, '')
            ->files(self::PLATFORM_IMAGES_PATH, $dir)
            ->files(self::PLATFORM_IMAGES_WRITABLE, is_writable('..' . $dir));
        return $this;
    }

}

/**
 * Class Bridge_Platform_VBulletin
 */
class Bridge_Platform_Vbulletin extends Bridge_Platform_Abstract
{

    /**
     * @var array
     */
    protected $original = array(
        array('/core/includes/config.php', '/core/includes/class_core.php'),
        array('/includes/config.php', '/includes/class_core.php'),
    );

    /**
     * @return $this
     * @throws Bridge_Exception
     */
    public function getConfiguration()
    {
        $this->type('VBulletin')
            ->version($this->getConfigVar('FILE_VERSION'))
            ->setDatabaseHost($this->getConfigVar('config[MasterServer][servername]'))
            ->database(self::DATABASE_PORT, $this->getConfigVar('config[MasterServer][port]', 3306))
            ->database(self::DATABASE_USER, $this->getConfigVar('config[MasterServer][username]'))
            ->database(self::DATABASE_PASSWORD, $this->getConfigVar('config[MasterServer][password]'))
            ->database(self::DATABASE_DATABASE, $this->getConfigVar('config[Database][dbname]'))
            ->database(self::DATABASE_PREFIX, $this->getConfigVar('config[Database][tableprefix]'))
            ->database(self::DATABASE_CHARSET, '')
            ->files(self::PLATFORM_IMAGES_PATH, is_dir('../core/images') ? '/core' : '/')
            ->files(self::PLATFORM_IMAGES_WRITABLE, true);

        return $this;
    }

}

/**
 * Class Bridge_Platform_SilverStripe
 */
class Bridge_Platform_SilverStripe extends Bridge_Platform_Abstract
{

    /**
     * @var array
     */
    protected $original = array(
        array('/mysite/_config.php', '/cms/silverstripe_version')
    );

    /**
     * @return array
     */
    public function getPatterns()
    {
        $this->patterns[] = '/[\'\"](server|username|password|database|path)[\'\"].*?[\'\"](.*?)[\'\"]/im';
        return $this->patterns;
    }

    /**
     * @return $this
     * @throws Bridge_Exception
     */
    public function getConfiguration()
    {
        $this->type('SilverStripe')
            ->version($this->getVersion())
            ->setDatabaseHost($this->getConfigVar('server'))
            ->database(self::DATABASE_USER, $this->getConfigVar('username'))
            ->database(self::DATABASE_PASSWORD, $this->getConfigVar('password'))
            ->database(self::DATABASE_DATABASE, $this->getConfigVar('database'))
            ->database(self::DATABASE_PREFIX, $this->getConfigVar('path'))
            ->database(self::DATABASE_CHARSET, '')
            ->files(self::PLATFORM_IMAGES_PATH, '/assets/Uploads')
            ->files(self::PLATFORM_IMAGES_WRITABLE, is_writable('../assets/Uploads') || is_writable('../assets/Uploads'));

        return $this;
    }

    /**
     * @return string
     */
    protected function getVersion()
    {
        preg_match('/\d([\.\d]?)+/', @file_get_contents('../cms/silverstripe_version'), $match);

        return isset($match[0]) ? $match[0] : '3.1.0';
    }

}

/**
 * Class Bridge_Platform_MyBB
 */
class Bridge_Platform_phpBB extends Bridge_Platform_Abstract
{

    /**
     * @var array
     */
    protected $original = array(
        array('/config.php', '/includes/constants.php'),
    );

    /**
     * @return $this
     * @throws Bridge_Exception
     */
    public function getConfiguration()
    {
        $this->type('phpBB')
            ->version($this->getConfigVar('PHPBB_VERSION', 2))
            ->setDatabaseHost($this->getConfigVar('dbhost'))
            ->database(self::DATABASE_USER, $this->getConfigVar('dbuser'))
            ->database(self::DATABASE_PASSWORD, $this->getConfigVar('dbpasswd'))
            ->database(self::DATABASE_DATABASE, $this->getConfigVar('dbname'))
            ->database(self::DATABASE_PREFIX, $this->getConfigVar('table_prefix'))
            ->database(self::DATABASE_CHARSET, '')
            ->files(self::PLATFORM_IMAGES_PATH, '/')
            ->files(self::PLATFORM_ATTACHMENTS_PATH, '/')
            ->files(
                self::PLATFORM_IMAGES_WRITABLE,
                ((is_dir('../images/avatars/upload') && is_writable('../images/avatars/upload')) || is_writable('../images/avatars')) && (false === is_dir('../files') || is_writable('../files'))
            );

        return $this;
    }

    /**
     * @return bool
     */
    public function clearCache()
    {
        $cache = glob('../cache/*.php');
        if (false !== $cache) {
            foreach ($cache as $file) {
                @chmod($file, 0777);
                @unlink($file);
            }

            return true;
        }

        return false;
    }

}

/**
 * Class Bridge_Platform_MediaWiki
 */
class Bridge_Platform_MediaWiki extends Bridge_Platform_Abstract
{

    /**
     * @var array
     */
    protected $original = array(
        array('/includes/DefaultSettings.php','/LocalSettings.php'),
    );

    /**
     * @return $this
     * @throws Bridge_Exception
     */
    public function getConfiguration()
    {
        $this->type('MediaWiki')
            ->version($this->getConfigVar('wgVersion'))
            ->setDatabaseHost($this->getConfigVar('wgDBserver'))
            ->database(self::DATABASE_USER, $this->getConfigVar('wgDBuser'))
            ->database(self::DATABASE_PASSWORD, $this->getConfigVar('wgDBpassword'))
            ->database(self::DATABASE_DATABASE, $this->getConfigVar('wgDBname'))
            ->database(self::DATABASE_PREFIX, $this->getConfigVar('wgDBprefix'))
            ->database(self::DATABASE_CHARSET, '')
            ->files(self::PLATFORM_IMAGES_PATH, '/images')
            ->files(self::PLATFORM_IMAGES_WRITABLE, is_writable('../images'));

        return $this;
    }

}

/**
 * Class Bridge_Platform_ExpressionEngine
 */
class Bridge_Platform_ExpressionEngine extends Bridge_Platform_Abstract
{

    /**
     * @var array
     */
    protected $original = array(
        array('/system/user/config/config.php'),
        array('/system/expressionengine/config/config.php', '/system/expressionengine/config/database.php'),
    );

    /**
     * @return array
     */
    public function getPatterns()
    {
        $this->patterns = array(
            '/[\'"](hostname|database|username|password|dbprefix|app_version|char_set|port)[\'"].*?[\'"](.*?)[\'"]/im'
        );

        return $this->patterns;
    }

    /**
     * @return $this
     * @throws Bridge_Exception
     */
    public function getConfiguration()
    {
        $this->type('ExpressionEngine')
            ->version($this->getConfigVar('app_version', 1))
            ->setDatabaseHost($this->getConfigVar('hostname'))
            ->database(self::DATABASE_USER, $this->getConfigVar('username'))
            ->database(self::DATABASE_PASSWORD, $this->getConfigVar('password'))
            ->database(self::DATABASE_DATABASE, $this->getConfigVar('database'))
            ->database(self::DATABASE_PREFIX, $this->getConfigVar('dbprefix'))
            ->database(self::DATABASE_CHARSET, $this->getConfigVar('char_set', 'utf8', false))
            ->database(self::DATABASE_PORT, $this->getConfigVar('port', 3306, false))
            ->files(self::PLATFORM_IMAGES_PATH, '/images')
            ->files(self::PLATFORM_IMAGES_WRITABLE, is_writable('../images'));

        return $this;
    }

    /**
     * @return bool|array
     */
    public function valid()
    {
        $indexFile = @file_get_contents('../index.php');
        // detect custom system dir
        if ($indexFile && preg_match("/\\\$system_path\s*=\s*['\"]([^'\"]+)['\"]\s*;/im", $indexFile, $match)) {
            $sysPath = rtrim($match[1], '/') . '/';
            foreach ($this->original as &$paths) {
                foreach ($paths as &$path) {
                    $path = str_replace('/system/', $sysPath, $path);
                }
            }
        }

        return parent::valid();
    }

}

header('X-Robots-Tag: noindex');

if (false == file_exists('./key.php')) {
    exit('KEY not found');
}

require_once './key.php';

$request = new Bridge_Library_Request($_REQUEST);
$request->handle();
