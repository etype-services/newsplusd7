<?php 
/* 	
If you see this text in your browser, PHP is not configured correctly on this hosting provider. 
Contact your hosting provider regarding PHP configuration for your site.

PHP file generated by Adobe Muse CC 2018.1.0.386
*/

require_once('form_process.php');

$form = array(
	'subject' => 'CONTACT Form Submission',
	'heading' => 'New Form Submission',
	'success_redirect' => '',
	'resources' => array(
		'checkbox_checked' => 'Checked',
		'checkbox_unchecked' => 'Unchecked',
		'submitted_from' => 'Form submitted from website: %s',
		'submitted_by' => 'Visitor IP address: %s',
		'too_many_submissions' => 'Too many recent submissions from this IP',
		'failed_to_send_email' => 'Failed to send email',
		'invalid_reCAPTCHA_private_key' => 'Invalid reCAPTCHA private key.',
		'invalid_reCAPTCHA2_private_key' => 'Invalid reCAPTCHA 2.0 private key.',
		'invalid_reCAPTCHA2_server_response' => 'Invalid reCAPTCHA 2.0 server response.',
		'invalid_field_type' => 'Unknown field type \'%s\'.',
		'invalid_form_config' => 'Field \'%s\' has an invalid configuration.',
		'unknown_method' => 'Unknown server request method'
	),
	'email' => array(
		'from' => 'info@LoneStarLiterary.com',
		'to' => 'info@LoneStarLiterary.com'
	),
	'fields' => array(
		'custom_U15816' => array(
			'order' => 1,
			'type' => 'string',
			'label' => 'First name',
			'required' => true,
			'errors' => array(
				'required' => 'Field \'First name\' is required.'
			)
		),
		'Email' => array(
			'order' => 3,
			'type' => 'email',
			'label' => 'Email',
			'required' => true,
			'errors' => array(
				'required' => 'Field \'Email\' is required.',
				'format' => 'Field \'Email\' has an invalid email.'
			)
		),
		'custom_U15812' => array(
			'order' => 4,
			'type' => 'string',
			'label' => 'Company (if applicable)',
			'required' => false,
			'errors' => array(
			)
		),
		'custom_U15824' => array(
			'order' => 5,
			'type' => 'string',
			'label' => 'Mailing Address',
			'required' => true,
			'errors' => array(
				'required' => 'Field \'Mailing Address\' is required.'
			)
		),
		'custom_U15792' => array(
			'order' => 6,
			'type' => 'string',
			'label' => 'City',
			'required' => true,
			'errors' => array(
				'required' => 'Field \'City\' is required.'
			)
		),
		'custom_U15796' => array(
			'order' => 7,
			'type' => 'string',
			'label' => 'State',
			'required' => true,
			'errors' => array(
				'required' => 'Field \'State\' is required.'
			)
		),
		'custom_U15766' => array(
			'order' => 8,
			'type' => 'string',
			'label' => 'ZIP / Postal Code',
			'required' => true,
			'errors' => array(
				'required' => 'Field \'ZIP / Postal Code\' is required.'
			)
		),
		'custom_U15784' => array(
			'order' => 9,
			'type' => 'string',
			'label' => 'Country',
			'required' => true,
			'errors' => array(
				'required' => 'Field \'Country\' is required.'
			)
		),
		'custom_U15820' => array(
			'order' => 13,
			'type' => 'string',
			'label' => 'Message (optional)',
			'required' => false,
			'errors' => array(
			)
		),
		'custom_U15833' => array(
			'order' => 11,
			'type' => 'string',
			'label' => 'Phone (optional)',
			'required' => false,
			'errors' => array(
			)
		),
		'custom_U15837' => array(
			'order' => 10,
			'type' => 'string',
			'label' => 'Website (optional)',
			'required' => false,
			'errors' => array(
			)
		),
		'custom_U15771' => array(
			'order' => 12,
			'type' => 'string',
			'label' => 'Mobile Phone (optional)',
			'required' => false,
			'errors' => array(
			)
		),
		'custom_U15804' => array(
			'order' => 14,
			'type' => 'checkbox',
			'label' => 'I’m a reader',
			'required' => false,
			'errors' => array(
			)
		),
		'custom_U15788' => array(
			'order' => 15,
			'type' => 'checkbox',
			'label' => 'I’m a writer/author',
			'required' => false,
			'errors' => array(
			)
		),
		'custom_U15808' => array(
			'order' => 16,
			'type' => 'checkbox',
			'label' => 'I’m a librarian',
			'required' => false,
			'errors' => array(
			)
		),
		'custom_U15842' => array(
			'order' => 17,
			'type' => 'checkbox',
			'label' => 'I’m an agent or editor',
			'required' => false,
			'errors' => array(
			)
		),
		'custom_U15828' => array(
			'order' => 18,
			'type' => 'checkbox',
			'label' => 'I represent a publisher or organization',
			'required' => false,
			'errors' => array(
			)
		),
		'custom_U15775' => array(
			'order' => 19,
			'type' => 'checkbox',
			'label' => 'Sign me up for Lone Star Literary Life news!',
			'required' => false,
			'errors' => array(
			)
		),
		'custom_U15800' => array(
			'order' => 2,
			'type' => 'string',
			'label' => 'Last Name',
			'required' => true,
			'errors' => array(
				'required' => 'Field \'Last Name\' is required.'
			)
		)
	)
);

process_form($form);
?>
