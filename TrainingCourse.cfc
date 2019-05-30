/**
* @name			TrainingCourse
* @displayname	Training Course
* @hint			Provides interaction with TrainingCourse object
* @author 		Brent Pruitt
* @extends		lib.com.training.TrainingService
* @persistent	true
*
* =====================================================
*	@notes
*
*/
component {

//meta
	property name = 'ID'					default = '';
	property name = 'IsActive'				default = true;

//text
	property name = 'Title'					default = '';
	property name = 'Type'					default = '';
	property name = 'Product'				default = '';
	property name = 'Date'					default = '';
	property name = 'DateFormat'			default = '';
	property name = 'DateSort'				default = '';
	property name = 'Location'				default = '';
	property name = 'Info'					default = '';
	property name = 'Description'			default = '';
	property name = 'Price'					default = 0;
	property name = 'Detail'				default = '';
	property name = 'DetailURL'				default = '';
	property name = 'RegistrationURL'		default = '';
	property name = 'RegistrationTitle'		default = 'Register Now';

	/*
		additional properties provided by LMS API

		id	0				type = 'numeric'
		DetailURL			type = 'text'
		RegistrationTitle	type = 'text'
		RegistrationURL		type = 'text'
		admin_description 	type = 'text' formatted: date text | location text | description text
		catalog_id
		product-type
		duration			0
		info_page			html
		name					type = 'text'
		passing_score		0	type = 'numeric'
		price				0	type = 'numeric'
		//is_active			[empty string] :: use publicly_listed
		publicly_listed 	yes|no	type = 'text'
		//lms_version		10.30

	*/



	/**
	*
	* @name			init
	* @hint			Creates Training Course object
	*
	* @output		false
	* @returns		TrainingCourse
	*
	*/
	public TrainingCourse function init(
		struct course = {}
	) {

		var local.course = arguments.course;

		if ( structIsEmpty( local.course ) ) {

			return;

		}

		if ( structkeyexists( local.course, 'id' ) ) {

			setID( local.course.id );

		} else {

			setID();

		}

		if ( structkeyexists( local.course, 'publicly_listed' ) ) {

			setIsActive( local.course.publicly_listed );

		} else {

			setIsActive();

		}

		if ( structkeyexists( local.course, 'name' ) ) {

			setTitle( local.course.name );

		} else {

			setTitle();

		}

		if ( structkeyexists( local.course, 'catalog_id' ) ) {

			setType( local.course.catalog_id );

		} else {

			setType();

		}

		if ( structkeyexists( local.course, 'catalog_id' ) ) {

			setProduct( local.course.catalog_id );

		} else {

			setProduct();

		}

		if ( structkeyexists( local.course, 'admin_description' ) ) {

			setDate( local.course.admin_description );

		} else {

			setDate();

		}

		setDateSort();

		setDateFormat();

		if ( structkeyexists( local.course, 'admin_description' ) ) {

			setLocation( local.course.admin_description );

		} else {

			setLocation();

		}

		if ( structkeyexists( local.course, 'admin_description' ) ) {

			setInfo( local.course.admin_description );

		} else {

			setInfo();

		}

		if ( structkeyexists( local.course, 'admin_description' ) ) {

			setDescription( local.course.admin_description );

		} else {

			setDescription();

		}

		if ( structkeyexists( local.course, 'info_page' ) ) {

			setDetail( local.course.info_page );

		} else {

			setDetail();

		}

		if ( structkeyexists( local.course, 'price' ) ) {

			setPrice( local.course.price );

		} else {

			setPrice();

		}

		if ( structkeyexists( local.course, 'name' ) ) {

			setRegistrationURL();

		} else {

			setRegistrationURL();

		}

		setDetailURL();
		setRegistrationTitle();

		return this;

	}



	/**
	*
	* @name			getInstance
	* @hint			Accesses TrainingCourse Instance
	*
	* @output		false
	* @returns		TrainingCourse Instance
	*
	*/
	public function getInstance() {

		return this;

	}



	/**
	*
	* @name
	* @hint			Accesses
	*
	* @output		false
	* @returns		numeric
	*
	*/
	public numeric function setID( numeric ID = 0 ) {

		this.ID = arguments.ID;

		return this.ID;

	}



	/**
	*
	* @name
	* @hint			Accesses
	*
	* @output		false
	* @returns		numeric
	*
	*/
	public numeric function getID() {

		return this.ID;

	}



	/**
	*
	* @name
	* @hint			Accesses
	*
	* @output		false
	* @returns		string
	*
	*/
	public string function setIsActive( string IsActive = 'no' ) {

		this.IsActive = trim( arguments.IsActive );

		return this.IsActive;

	}



	/**
	*
	* @name
	* @hint			Accesses
	*
	* @output		false
	* @returns		string
	*
	*/
	public string function getIsActive() {

		return this.IsActive;

	}



	/**
	*
	* @name
	* @hint			Accesses
	*
	* @output		false
	* @returns		string
	*
	*/
	public string function setTitle( string Title = '' ) {

		this.Title = trim( arguments.Title );
		return this.Title;

	}



	/**
	*
	* @name
	* @hint			Accesses
	*
	* @output		false
	* @returns		string
	*
	*/
	public string function getTitle() {

		return this.Title;

	}



	/**
	*
	* @name
	* @hint			Accesses
	*
	* @output		false
	* @returns		string
	*
	*/
	public string function setType( string Type = '', string delimeter = '-' ) {

		this.Type = trim( arguments.Type );
		local.delimeter = arguments.delimeter;

		if ( FindNoCase( local.delimeter, this.Type ) ) {

			this.Type = Mid( this.Type, FindNoCase( local.delimeter, this.Type ) + 1, len( this.Type ) );

		}

		return this.Type;

	}



	/**
	*
	* @name
	* @hint			Accesses
	*
	* @output		false
	* @returns		string
	*
	*/
	public string function getType() {

		//if ( ! structkeyexists( this, 'Type' ) ) { setType( arguments.Type ); }
		return this.Type;

	}



	/**
	*
	* @name
	* @hint			Accesses
	*
	* @output		false
	* @returns		string
	*
	*/
	public string function setProduct( string Product = '', string delimeter = '-' ) {

		this.Product = trim( arguments.Product );
		local.delimeter = arguments.delimeter;

		if ( FindNoCase( local.delimeter, this.Product ) gt 0 ) {

			this.Product = Mid( this.Product, 1, FindNoCase( local.delimeter, this.Product ) - 1 );

		}

		return this.Product;

	}



	/**
	*
	* @name
	* @hint			Accesses
	*
	* @output		false
	* @returns		string
	*
	*/
	public string function getProduct() {

		//if ( ! structkeyexists( this, 'Product' ) ) { setProduct( arguments.Product ); }
		return this.Product;

	}



	/**
	*
	* @name
	* @hint			Accesses
	*
	* @output		false
	* @returns		string
	*
	*/
	public string function setDate(
		string Date = '',
		delimeter = '|'
	) {

		this.Date 			= trim( arguments.Date );
		local 				= {};
		local.stringOut 	= trim( arguments.Date );
		local.delimeter 	= arguments.delimeter;

		if (
			listlen( local.stringOut, local.delimeter ) eq 3
			or listlen( local.stringOut, local.delimeter ) eq 2
		) {

			local.stringOut = ''
					& trim( listGetAt( local.stringOut, 1, local.delimeter ) )
				;

		} else {

			local.stringOut = '';//replace( local.stringOut, '|', '<br/>', 'all' );

		}

		this.Date = local.stringOut;

		return this.Date;

	}



	/**
	*
	* @name
	* @hint			Accesses
	*
	* @output		false
	* @returns		string
	*
	*/
	public string function getDate() {

		return this.Date;

	}



	/**
	*
	* @name
	* @hint			Accesses
	*
	* @output		false
	* @returns		string
	*
	*/
	public string function setDateFormat() {

		this.DateFormat 	= '';
		local 				= {};
		local.Date 			= getDate();
		local.DateFormat 	= local.Date;

		if ( len( local.Date ) ) {

			if (
				ListLen( local.Date, '-' ) eq 3
				and len( local.Date ) eq 10
			) {

				//yyyy-mm-dd
				if ( isDate( local.Date ) ) {

					local.DateFormat = DateFormat( local.Date, 'MMMM DD, YYYY' );

				}

			} else if (
				ListLen( local.Date, '-' ) eq 6
				and len( local.Date ) eq 21
			) {

				//yyyy-mm-dd-yyyy-mm-dd
				local.DatePartFirst = Left( local.Date, 10 );
				local.DatePartLast = Right( local.Date, 10 );

				if (
					( isDate( local.DatePartFirst ) and isDate( local.DatePartLast ) )
					and ( DateCompare( local.DatePartFirst, local.DatePartLast ) is -1 )
				) {

					local.DateFormat = $.getBean('DateFormatter').DateRangeFormat( local.DatePartFirst, local.DatePartLast );

				} else {

					local.DateFormat = local.DatePartFirst & ' &ndash; ' & local.DatePartLast;

				}

			}

			this.DateFormat = ''
					& '<span class="date">'
					& local.DateFormat
					& '</span>'
				;

		}

		return this.DateFormat;

	}



	/**
	*
	* @name
	* @hint			Accesses
	*
	* @output		false
	* @returns		string
	*
	*/
	public string function getDateFormat() {

		return this.DateFormat;

	}



	/**
	*
	* @name
	* @hint			Accesses
	*
	* @output		false
	* @returns		string
	*
	*/
	public string function setDateSort() {

		this.DateSort 	= getDate();
		local 			= {};
		local.DateSort 	= this.DateSort;

		if ( len( local.DateSort ) ) {

			if (
				ListLen( local.DateSort, '-' ) eq 3
				and len( local.DateSort ) eq 10
			) {

				//yyyy-mm-dd
				if ( isDate( local.DateSort ) ) {

					local.DateSort = DateFormat( local.DateSort, 'YYYYMMDD' );

				}

			} else if (
				ListLen( local.DateSort, '-' ) eq 6
				and len( local.DateSort ) eq 21
			) {

				//yyyy-mm-dd-yyyy-mm-dd
				local.DateSort = Left( local.DateSort, 10 );

			}

		}

		if ( isDate( local.DateSort ) ) {

			local.DateSort = DateFormat( local.DateSort, 'YYYYMMDD' );

		}

		this.DateSort = rereplacenocase( local.DateSort, '[^[:digit:]]', '', 'all' );

		return this.DateSort;

	}



	/**
	*
	* @name
	* @hint			Accesses
	*
	* @output		false
	* @returns		string
	*
	*/
	public string function getDateSort() {

		return this.DateSort;

	}



	/**
	*
	* @name
	* @hint			Accesses
	*
	* @output		false
	* @returns		string
	*
	*/
	public string function setLocation( string Location = '', delimeter = '|' ) {

		this.Location 	= trim( arguments.Location );
		local 			= {};
		local.stringOut = trim( arguments.Location );
		local.delimeter = arguments.delimeter;

		if (
			listlen( local.stringOut, local.delimeter ) eq 3
			or listlen( local.stringOut, local.delimeter ) eq 2
		) {

			local.stringOut = ''
					& trim( listGetAt( local.stringOut, 2, local.delimeter ) )
				;

		} else {

			local.stringOut = '';//replace( local.stringOut, '|', '<br/>', 'all' );

		}

		this.Location = local.stringOut;

		return this.Location;

	}



	/**
	*
	* @name
	* @hint			Accesses
	*
	* @output		false
	* @returns		string
	*
	*/
	public string function getLocation() {

		return this.Location;

	}



	/**
	*
	* @name
	* @hint			Accesses
	*
	* @output		false
	* @returns		string
	*
	*/
	public string function getLocationFormat() {

		this.LocationFormat = '';

		if ( len( getLocation() ) ) {

			this.LocationFormat = ''
					& '<span class="location">'
					& getLocation()
					& '</span>'
				;

		}

		return this.LocationFormat;

	}



	/**
	*
	* @name
	* @hint			Accesses
	*
	* @output		false
	* @returns		string
	*
	*/
	public string function setInfo( string Info = '', delimeter = '|' ) {

		this.Info = trim( arguments.Info );
		local = {};
		local.stringOut = trim( arguments.Info );
		local.delimeter = arguments.delimeter;

		if ( listlen( local.stringOut, local.delimeter ) eq 3 ) {

			local.stringOut = ''
					& trim( listGetAt( local.stringOut, 3, local.delimeter ) )
				;

		}

		this.Info = local.stringOut;

		return this.Info;

	}



	/**
	*
	* @name
	* @hint			Accesses
	*
	* @output		false
	* @returns		string
	*
	*/
	public string function getInfo() {

		return this.Info;

	}



	/**
	*
	* @name
	* @hint			Accesses
	*
	* @output		false
	* @returns		string
	*
	*/
	public string function getInfoFormat() {

		this.InfoFormat = '';

		if ( len( getInfo() ) ) {

			this.InfoFormat = ''
					& '<span class="info">'
					& getInfo()
					& '</span>'
				;

		}

		return this.InfoFormat;

	}



	/**
	*
	* @name
	* @hint			Accesses
	*
	* @output		false
	* @returns		string
	*
	*/
	public string function setDescription(
		string Description = '',
		delimeter = '|'
	) {

		this.Description 	= arguments.Description;

		local 				= {};
		local.stringOut 	= trim( arguments.Description );
		local.stringFormat 	= getDateFormat() & getLocationFormat() & getInfoFormat();
		local.delimeter 	= arguments.delimeter;

		if ( len( local.stringFormat ) gt 0 ) {

			local.stringOut = local.stringFormat;

		} else {

			local.stringOut = replace( local.stringOut, '|', '<br/>', 'all' );

		}

		this.Description = local.stringOut;

		return this.Description;

	}



	/**
	*
	* @name
	* @hint			Accesses
	*
	* @output		false
	* @returns		string
	*
	*/
	public string function getDescription() {

		return this.Description;

	}



	/**
	*
	* @name
	* @hint			Accesses
	*
	* @output		false
	* @returns		string
	*
	*/
	public string function getDescriptionFormat() {

		this.DescriptionFormat = ''
					& '<span class="content">'
					& getDescription()
					& '</span>'
				;

		return this.DescriptionFormat;

	}



	/**
	*
	* @name
	* @hint			Accesses
	*
	* @output		false
	* @returns		string
	*
	*/
	public string function setPrice( string Price = 0 ) {

		this.Price = arguments.Price;

		return this.Price;

	}



	/**
	*
	* @name
	* @hint			Accesses
	*
	* @output		false
	* @returns		string
	*
	*/
	public string function getPrice() {

		return this.Price;

	}



	/**
	*
	* @name
	* @hint			Accesses
	*
	* @output		false
	* @returns		string
	*
	*/
	public string function setDetail( string Detail = '' ) {

		this.Detail = arguments.Detail;

		return this.Detail;

	}



	/**
	*
	* @name
	* @hint			Accesses
	*
	* @output		false
	* @returns		string
	*
	*/
	public string function getDetail() {

		return this.Detail;

	}



	/**
	*
	* @name
	* @hint			Accesses
	*
	* @output		false
	* @returns		string
	*
	*/
	public string function setDetailURL(
		string DetailURL = '',
		string PrefixURL = getDetailBaseURL(),
		string ArgumentVariable = 'id'
	) {

		this.DetailURL = trim( arguments.DetailURL );
		local.PrefixURL = trim( arguments.PrefixURL );
		local.ArgumentVariable = trim( arguments.ArgumentVariable );
		this.DetailURL = local.PrefixURL
					& '?'
					& local.ArgumentVariable
					& '='
					& setURLTitle( this.getTitle() )
				;

		return this.DetailURL;

	}



	/**
	*
	* @name
	* @hint			Accesses
	*
	* @output		false
	* @returns		string
	*
	*/
	public string function getDetailURL() {

		return this.DetailURL;

	}



	/**
	*
	* @name
	* @hint			Accesses
	*
	* @output		false
	* @returns		string
	*
	*/
//		hint='course registration'
	public string function setRegistrationURL() {

		this.RegistrationURL = getRegistrationBaseURL()
								& setURLTitle( this.getTitle() )
								& '&';

		return this.RegistrationURL;

	}



	/**
	*
	* @name
	* @hint			Accesses
	*
	* @output		false
	* @returns		string
	*
	*/
	public string function getRegistrationURL() {

		return this.RegistrationURL;

	}



	/**
	*
	* @name
	* @hint			Accesses
	*
	* @output		false
	* @returns		string
	*
	*/
	public string function setRegistrationTitle( string RegistrationTitle = super.getRegistrationTitle() ) {

		this.RegistrationTitle = trim( arguments.RegistrationTitle );

		return this.RegistrationTitle;

	}



	/**
	*
	* @name			getRegistrationTitle
	* @hint			Accesses
	*
	* @output		false
	* @returns		string
	*
	*/
	public string function getRegistrationTitle() {

		return this.RegistrationTitle;

	}

}