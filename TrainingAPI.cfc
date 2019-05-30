/**
* @name			TrainingAPI
* @displayname	Training API
* @hint			Generates settings for TrainingAPI
* @author 		Brent Pruitt
*	=====================================================
*	@notes
*		API TEST:
*		{$api_domain}/lms/apibuilder.php?auth={{authcode}}&command=course__getcount&p1=admin&p2=&p3=&p4=&p5=&execute_api=1
*
*/
component {

	property name = 'API' type = 'struct';

	/**
	* @name			init
	* @hint			Initializes TrainingAPI
	* @returns		TrainingAPI
	*	=====================================================
	*	@notes
	*/
	public TrainingAPI function init(){

		//this.setAPI( arguments );

		return this;

	}


	/**
	*
	* @name			getInstance
	* @hint			Accesses TrainingAPI Instance
	* @returns		TrainingAPI Instance
	*
	*/
	public function getInstance() {

		return this;

	}


	/**
	*
	* @name			getVariables
	* @hint			Accesses all variables
	* @returns		struct
	*
	*/
	public function getVariables(){

		return variables;

	}


	/**
	*
	* @name			setAPI
	* @hint			Assigns API default variables
	* @returns		struct
	*
	*/
	public struct function setAPI(){

		variables['API'] = {};
		variables['API']['BaseURL'] 		= getBaseURL();
		variables['API']['CommandList'] 	= getCommandList();
		variables['API']['Key'] 			= getKey();
		variables['API']['Domain'] 			= getDomain();
		variables['API']['Username'] 		= getUsername();
		variables['API']['Status'] 			= getAPIStatus();

		return variables['API'];

	}


	/**
	*
	* @name			getAPI
	* @hint			Accesses API variable struct
	* @returns		struct
	*
	*/
	public struct function getAPI(){

		if ( ! structkeyexists( variables, 'API' ) ){

			setAPI();

		}

		return variables['API'];

	}


	/**
	*
	* @name			setEmailAdmin
	* @hint			Populates notification email for API administrator
	* @default		empty
	* @returns		string
	*
	*/
	public string function setEmailAdmin( string email = '' ) {

		variables['EmailAdmin'] = trim( arguments.email );

		return variables['EmailAdmin'];

	}


	/**
	*
	* @name			getEmailAdmin
	* @hint			Retrieves notification email for API administrator
	* @returns		string
	*
	*/
	public function getEmailAdmin() {

		if ( ! structkeyexists( variables, 'EmailAdmin' ) ) {

			setEmailAdmin();

		}

		return variables['EmailAdmin'];

	}


	/**
	*
	* @name			setEmailNotification
	* @hint			Adds email for reporting API usage
	* @default		empty
	* @returns		string
	*
	*/
	public string function setEmailNotification( string email = '' ) {

		variables['EmailNotification'] = trim( arguments.email );

		return variables['EmailNotification'];

	}


	/**
	*
	* @name			getEmailNotification
	* @hint			Accesses Email for reporting API usage
	* @returns		string
	*
	*/
	public string function getEmailNotification() {

		if ( ! structkeyexists( variables, 'EmailNotification' ) ){

			setEmailNotification();

		}

		return variables['EmailNotification'];

	}


	/**
	*
	* @name			getInstance
	* @hint			Sets number of courses to display per page
	* @default 		25
	* @returns		number
	*
	*/
	public numeric function setDisplayPerPage( numeric DisplayPerPage = 25 ) {

		variables.DisplayPerPage = arguments.DisplayPerPage;

		return variables.DisplayPerPage;

	}


	/**
	*
	* @name			getDisplayPerPage
	* @hint			Retrieves number of courses to display per page
	* @returns		number
	*
	*/
	public numeric function getDisplayPerPage() {

		if ( ! structkeyexists( variables, 'DisplayPerPage' ) ) {

			setDisplayPerPage();

		}

		return variables.DisplayPerPage;

	}


	/**
	*
	* @name			setAPIStatus
	* @hint			Verifies required variables are set for API to access/retrieve data
	* @default		false
	* @returns		boolean
	*
	*/
	public boolean function setAPIStatus(){

		variables['APIStatus'] = (
									structkeyexists( variables, 'key' )
									and structkeyexists( variables, 'domain' )
									and structkeyexists( variables, 'username' )
									and (
										this.getKey() neq ''
										and this.getDomain() neq ''
										and getUsername() neq ''
									)
								)
								? true
								: false;

		return variables['APIStatus'];

	}


	/**
	*
	* @name			getAPIStatus
	* @hint			Accesses TrainingAPI Instance
	* @returns		boolean
	*
	*/
	public boolean function getAPIStatus() {

		if ( ! structkeyexists( variables, 'APIStatus' ) ){

			setAPIStatus();

		}

		return variables['APIStatus'];

	}


	/**
	*
	* @name			setBaseURL
	* @hint			Creates base url for connection to LMS
	* @returns		string
	*
	*	=====================================================
	*	@notes
	*
	*		FORMAT:
	* 		{$api_domain}lms/api.php?auth={$api_key}&command=
	*
	*/
	public string function setBaseURL() {

		variables.BaseURL = (
								( this.getDomain() contains '://' )
									? ''
									: this.getProtocol()
							)
							& this.getDomain()
							& 'lms/api.php'
							& '?auth='
							& this.getKey()
							& '&command='
							;

		return variables.BaseURL;

	}


	/**
	*
	* @name			getBaseURL
	* @hint			Accesses connection base url
	* @returns		string
	*
	*/
	public string function getBaseURL() {

		if ( ! structkeyexists( variables, 'BaseURL' ) ) {

			setBaseURL();

		}

		return variables.BaseURL;

	}


	/**
	*
	* @name			setProtocol
	* @hint			Should be set to default secure protocol, but allows insecure override
	* @default		ssl protocol
	*
	* @output		false
	* @returns		string
	*
	*/
	public string function setProtocol( string ssl = 'ssl' ) {

		variables.protocol = (
								arguments.ssl is not 'ssl'
								and arguments.ssl is not 'https://'
							)
							? 'http://'
							: 'https://';

		return variables.protocol;

	}


	/**
	*
	* @name			getProtocol
	* @hint			Protocol for access to LMS
	*
	* @output		false
	* @returns		string
	*
	*/
	public string function getProtocol() {

		if ( ! structkeyexists( variables, 'protocol' ) ) {

			setProtocol();

		}

		return variables.protocol;
	}


	/**
	*
	* @name			setKey
	* @hint			Sets API Auth Key provided by LMS
	*
	* @output		false
	* @returns		string
	*
	*/
	public string function setKey( string key = '' ) {

		if ( ! structkeyexists( variables, 'key' ) ) {

			variables.key = trim( arguments.key );

		}

		return variables.key;
	}


	/**
	*
	* @name			getKey
	* @hint			Accesses API Auth Key provided by LMS
	*
	* @output		false
	* @returns		string Instance
	*
	*/
	public string function getKey() {

		if ( ! structkeyexists( variables, 'key' ) ){

			setKey();

		}

		return variables.key;

	}


	/**
	*
	* @name			setDomain
	* @hint			Sets domain to access LMS
	*
	* @output		false
	* @returns		string
	*
	*	=====================================================
	*	@notes
	*
	*		Allows interchangability of host domain:
	*		LMS-hosted, on-prem, subdomains, dev or production environments etc
	*
	*/
	public string function setDomain( string domain = '' ) {

		if ( ! structkeyexists( variables, 'domain' ) ){

			variables.domain = trim( arguments.domain );

		}

		return variables.domain;

	}


	/**
	*
	* @name			getDomain
	* @hint			Retrieves LMS Host Domain
	*
	* @output		false
	* @returns		string
	*
	*/
	public string function getDomain() {

		if ( ! structkeyexists( variables, 'domain' ) ) {

			setDomain();

		}

		return variables.domain;

	}


	/**
	*
	* @name			setUsername
	* @hint			Retrieves LMS account access username
	*
	* @output		false
	* @returns		string
	*
	*/
	public string function setUsername( string username = '' ) {

		if ( ! structkeyexists( variables, 'username' ) ){

			variables.username = trim( arguments.username );

		 }

		return variables.username;

	}


	/**
	*
	* @name			getUsername
	* @hint			Accesses API Username
	*
	* @output		false
	* @returns		string
	*
	*/
	public string function getUsername(){

		if ( ! structkeyexists( variables, 'username' ) ){

			setUsername();

		}

		return variables.username;

	}


	/**
	*
	* @name			setCommandList
	* @hint			Creates list of allowed commands for API
	*
	* @output		false
	* @returns		string	api commands in comma delimited list
	*
	* @see
	* 	https://files.atrixware.com/files/axis/resources/10.6_manuals/axis-lms.api.pdf
	*
	*/
	public string function setCommandList( string commandList = '' ) {

		if ( ! structkeyexists( variables, 'commandList' ) || arguments.commandList eq '' ) {

			variables.commandList = 'system__getApiVersion,partition__getCount,partition__getList,partition__getRecord,user__getCount,user__getList,user__getRecord,course__getCount,course__getList,course__getRecord,course__getUserList,course__enrollUser,report__getCourseInfo';

		}

		return variables.commandList;

	}


	/**
	*
	* @name			getCommandList
	* @hint			Retrieves permitted commands for use in API
	*
	* @output		false
	* @returns		string	api commands in comma delimited list
	*
	*/
	public string function getCommandList() {

		if ( ! structkeyexists( variables, 'commandList' ) ){

			setCommandList();

		}

		return variables.commandList;

	}


	/**
	*
	* @name			isCommand
	* @hint			Validates request with allowed commands for use in API
	*
	* @output		false
	* @returns		boolean
	*
	*/
	public boolean function isCommand( isCommandValue = '' ) {

		local = {};
		local.isCommand = false;
		local.isCommandValue = arguments.isCommandValue;

		if ( ListFindNoCase( getCommandList(), local.isCommandValue, ',' ) ) {

			local.isCommand = true;

		}

		return local.isCommand;

	}

}