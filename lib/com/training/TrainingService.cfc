/**
* @name			TrainingService
* @displayname	Training Service
* @hint			Provides interaction with TrainingAPI
* @author 		Brent Pruitt
* @extends		lib.com.training.TrainingAPI
*
* 	=====================================================
*	@notes
*		creates setTrainingAPI on init
*
*/
component {


	/**
	*
	* @name			init
	* @hint			Initializes TrainingService & API
	*
	* @returns		TrainingService //TrainingAPI
	*
	*/
	public TrainingService function init() {

		if ( ! structkeyexists( variables, 'courses' ) ) {

			variables.courses = {};

		}

		setTrainingAPI();

		return this;

	}


	/**
	*
	* @name			getInstance
	* @hint			Accesses TrainingService Instance
	*
	* @output		false
	* @returns		TrainingService Instance
	*
	*/
	public function getInstance() {

		return this;

	}


	/**
	*
	* @name			getVariables
	* @hint			Accesses all variables
	*
	* @output		false
	* @returns		struct
	*
	*/
	public function getVariables() {

		return getTrainingAPI().getVariables();

	}



	/**
	*
	* @name			setTrainingAPI
	* @hint			Generates TrainingAPI instance
	*
	* @output		false
	* @returns		TrainingAPI
	*
	*/
	public TrainingAPI function setTrainingAPI() {

		variables.TrainingAPI = createObject( 'component', 'lib.com.training.TrainingAPI' ).getInstance();

		return variables.TrainingAPI;

	}



	/**
	*
	* @name			getTrainingAPI
	* @hint			Retrieves API instance
	*
	* @output		false
	* @returns		TrainingAPI
	*
	*/
	public TrainingAPI function getTrainingAPI() {

		if (
			! structkeyexists( variables, 'TrainingAPI' )
			or variables.TrainingAPI neq IsInstanceOf( 'component', 'TrainingAPI' )
		) {

			setTrainingAPI();

		}

		return variables.TrainingAPI;

	}



	/**
	*
	* @name			setRegistrationTitle
	* @hint			Adds label for Register Button
	* @param		string RegistrationTitle
	* @default		'Register Now'
	*
	* @output		false
	* @returns		string
	*
	*/
	public string function setRegistrationTitle( string RegistrationTitle = 'Register Now' ) {

		variables.RegistrationTitle = trim( arguments.RegistrationTitle );

		return variables.RegistrationTitle;

	}



	/**
	*
	* @name			RegistrationTitle
	* @hint			Retrieves Registration button label
	*
	* @output		false
	* @returns		string
	*
	*/
	public string function getRegistrationTitle() {

		if ( ! structkeyexists( variables, 'RegistrationTitle' ) ) {

			setRegistrationTitle();

		}

		return variables.RegistrationTitle;

	}



	/**
	*
	* @name			setCommand
	* @hint			Generates valid API command
	* @param		string command
	* @defaults		'course__getList'
	*
	* @output		false
	* @returns		string
	*
	*/
	public string function setCommand( string command = 'course__getList' ) {

		if ( getTrainingAPI().isCommand( trim( arguments.command ) ) ) {

			variables.command = trim( arguments.command );

		 } else {

		 	throw( type = 'InvalidCommand', message = 'Command passed is not valid or permitted. Check the API documentation, or contact the administrator.' );

		 }

		return variables.command;

	}



	/**
	*
	* @name			getCommand
	* @hint			Retreives setCommand
	*
	* @output		false
	* @returns		string
	*
	*/
	public string function getCommand() {

		if ( ! structkeyexists( variables, 'command' ) ) {

			setCommand();

		}

		return variables.command;

	}



	/**
	*
	* @name			setRegistrationBaseURL
	* @hint			Creates base url for coures registration
	* @param		string RegistrationBaseURL
	*
	* @output		false
	* @returns		string
	*
	*/
	public string function setRegistrationBaseURL( string RegistrationBaseURL = '' ) {

		variables.RegistrationBaseURL = trim( arguments.RegistrationBaseURL );

		return variables.RegistrationBaseURL;

	}



	/**
	*
	* @name			getRegistrationBaseURL
	* @hint			Returns base url of course registration
	*
	* @output		false
	* @returns		string
	*
	*/
	public string function getRegistrationBaseURL() {

		if ( ! structkeyexists( variables, 'RegistrationBaseURL' ) ) {

			setRegistrationBaseURL();

		}

		return variables.RegistrationBaseURL;

	}



	/**
	*
	* @name			setRegistrationURL
	* @hint			Generates registration url for specified course
	* @param		string courseTitle
	*
	* @output		false
	* @returns		string
	*
	*/
	public string function setRegistrationURL( string courseTitle = '' ) {

		variables.RegistrationURL = '';
		local.courseTitle = trim( arguments.courseTitle );

		if ( len( local.courseTitle ) ) {

			variables.RegistrationURL = getRegistrationBaseURL() & setURLTitle( local.courseTitle ) & '&';

		}

		return variables.RegistrationURL;

	}



	/**
	*
	* @name			getRegistrationURL
	* @hint			Returns Registration URL for specified
	* @param		string courseTitle
	*
	* @output		false
	* @returns		string
	*
	*/
	public string function getRegistrationURL( string courseTitle = '' ) {

		return setRegistrationURL( arguments.courseTitle );

	}



	/**
	*
	* @name			setDetailBaseURL
	* @hint			Creates base url for course detail information page
	* @param		string DetailBaseURL
	*
	* @output		false
	* @returns		string
	*
	*/
	public string function setDetailBaseURL( string DetailBaseURL = './' ) {

		variables.DetailBaseURL = trim( arguments.DetailBaseURL );

		return variables.DetailBaseURL;

	}



	/**
	*
	* @name			getDetailBaseURL
	* @hint			Retrieves base url for course detail information page
	*
	* @output		false
	* @returns		string
	*
	*/
	public string function getDetailBaseURL() {

		if ( ! structkeyexists( variables, 'DetailBaseURL' ) ) {

			setDetailBaseURL();

		}

		return variables.DetailBaseURL;

	}



	/**
	*
	* @name			setURLTitle
	* @hint			Creates url parameter string from course title
	* @param		required string title
	*
	* @output		false
	* @returns		string
	*
	*/
	public string function setURLTitle( string title ) {

		local.title = arguments.title;

		if ( len( trim( local.title ) ) ) {

			local.title = reReplaceNoCase( local.title, '&amp;', '', 'all' ); //replace &amp;
			local.title = reReplaceNoCase( local.title, '&', 'and', 'all' ); //replace &
			local.title = reReplaceNoCase( trim( local.title ), '[\s]','+', 'all' );
			local.title = reReplaceNoCase( local.title, '[\-\-]+', '-', 'all' );

		 }

		return local.title;

	}



	/**
	*
	* @name			GetNewResponse
	* @hint			returns new API response struct
	*
	* @output		false
	* @returns		struct
	*
	*/
	public struct function GetNewResponse() {

		//Define the local scope
		var local = {};

		//Create new API response
		local.Response = {
			 Success 	= false
			,Errors 	= []
			,Data 		= ''
		};

		//Return the empty response object.
		return local.Response;

	}



	/**
	*
	* @name			getAPIData
	* @hint			Makes a call to the LMS API
	* @param		string urlString
	*
	* @output		false
	* @returnformat wddx
	* @returns		any
	*
	*/
	remote any function getAPIData(
		string urlString = ''
	) returnformat = 'wddx' {

		//define the local scope.
		var local 				= {};
		local.Response['Data'] 	= '';

		//get a new API resposne.
		local.Response 			= this.GetNewResponse();
		local.postURL 			= arguments.urlString;

		//local.id = arguments.id;
		//local.settings = ( isjson( arguments.settings ) ) ? DeserializeJSON( arguments.settings ) : arguments.settings;
		//serializeJSON( local.settings )

		try {

			httpService = new http();
			httpService.setMethod( 'get' );
			httpService.setCharset( 'utf-8' );
			httpService.setUrl( local.postURL );

			//httpService.addParam( type = 'formfield', name = 'api_key', value = getKey() );
			//httpService.addParam( type = 'formfield', name = 'consumer_secret', value = getSecret() );

			result = httpService.send().getPrefix();

			if( '200' == result.ResponseHeader['Status_Code'] ) {

				data.success = true;
				data.content = result;

				local.Response['Success'] 	= true;
				local.Response['Data'] 		= data.content.filecontent;

			} else {

				local.Response['Success'] 	= false;
				local.Response['Data'] 		= result;
				local.Response['Errors'] 	= ArrayAppend(
						local.Response['Errors']
						,'A connection error occurred.'
					);

			}

		}

		catch ( any err ) {

			local.Response['Success'] 	= false;
			local.Response['Data'] 		= '';
			local.Response['Errors'] 	= ArrayAppend(
						local.Response['Errors']
						,'A connection error occurred.'
					);

		}

		//Return the response.
		return local.Response;

	}



	/**
	*
	* @name			getCourseID
	* @hint			Returns course id from url parameter
	* @param		url.id
	*
	* @output		false
	* @returns		string
	*
	*/
	public string function getCourseID() {

		variables.CourseID = '';

		if (
			structkeyexists( url, 'id' )
			and trim( url.id ) neq ''
		) {

			variables.CourseID = trim( url.id );

		}

		return variables.CourseID;

	}



	/**
	*
	* @name			setCourseType
	* @hint			Parses course type or category from delimtied API string variable
	* @param		string CourseProduct
	* @param		string delimeter
	*
	* @output		false
	* @returns		string
	*
	*/
	public string function setCourseType( string CourseType = 'all', string delimeter = '-' ) {

		variables.CourseType =  lcase( trim( arguments.CourseType ) );
		local.delimeter = arguments.delimeter;

		if ( FindNoCase( local.delimeter, variables.CourseType ) gt 0 ) {

			variables.CourseType = Mid( variables.CourseType, FindNoCase( local.delimeter, variables.CourseType ) + 1, len( variables.CourseType ) );

		}

		if ( variables.CourseType eq '' ) {

			variables.CourseType = 'all';

		}

		return variables.CourseType;
	}



	/**
	*
	* @name			getCourseType
	* @hint			Retrieves course type or category from delimtied API string variable
	* @param		string CourseType
	* @param		string delimeter
	*
	* @output		false
	* @returns		string
	*
	*/
	public string function getCourseType( string CourseType = 'all', string delimeter = '-' ) {

		if ( ! structkeyexists( variables, 'CourseType' ) ) {

			variables.CourseType = setCourseType( arguments.CourseType, arguments.delimeter );

		}

		return variables.CourseType;

	}



	/**
	*
	* @name			setCourseProduct
	* @hint			Parses Product from delimtied API string variable
	* @param		string CourseProduct
	* @param		string delimeter
	*
	* @output		false
	* @returns		string
	*
	*/
	public string function setCourseProduct( string CourseProduct = '', string delimeter = '-' ) {

		variables.CourseProduct = lcase( trim( arguments.CourseProduct ) );
		local.delimeter = arguments.delimeter;

		if ( FindNoCase( local.delimeter, variables.CourseProduct ) gt 0 ) {

			variables.CourseProduct = Mid( variables.CourseProduct, 1, FindNoCase( local.delimeter, variables.CourseProduct ) - 1 );

		}

		return variables.CourseProduct;

	}



	/**
	*
	* @name			getCourseProduct
	* @hint			Retrieves associated Product from delimtied API string variable
	* @param		string CourseProduct
	* @param		string delimeter
	*
	* @output		false
	* @returns		string
	*
	*/
	public string function getCourseProduct(
		string CourseProduct = '',
		string delimeter = '-'
	) {

		if ( ! structkeyexists( variables, 'CourseProduct' ) ) {

			variables.CourseProduct = setCourseProduct( arguments.CourseProduct, arguments.delimeter );

		}

		return variables.CourseProduct;

	}



	/**
	*
	* @name			setFilter
	* @hint			Creates filter variable to narrow course results
	*
	* @output		false
	* @returns		string
	*
	*/
	public string function setFilter() {

		variables.CourseFilter = '';

		if ( getCourseProduct() neq '' and getCourseType() neq '' ) {

			variables.CourseFilter = listappend( getCourseProduct(), getCourseType(), '-' );

		}

		return variables.CourseFilter;

	}



	/**
	*
	* @name			getFilter
	* @hint			Retrieves Filter variable to narrow course results
	*
	* @output		false
	* @returns		string
	*
	*/
	public string function getFilter() {

		if ( ! structkeyexists( variables, 'CourseFilter' ) ) {

			setFilter();

		}

		return variables.CourseFilter;

	}



	/**
	*
	* @name			setParameters
	* @hint			Generates parameters struct for API call
	* @param		struct parameters
	*
	* @output		false
	* @returns		struct
	*
	* @notes
	* 	future method to separate parameter struct creation from getTrainingData
	*
	*/
	public struct function setParameters( any parameters ) {

		if ( ! structkeyexists( variables, 'parameters' ) ) {

			variables.parameters = arguments.parameters;

		 }

		return variables.parameters;

	}



	/**
	*
	* @name			getParameters
	* @hint			Retrieves set parameters
	*
	* @output		false
	* @returns		struct
	*
	*/
	public struct function getParameters() {

		if ( ! structkeyexists( variables, 'parameters' ) ) {

			setParameters();

		}

		return variables.parameters;

	}



	/**
	*
	* @name			getTrainingData
	* @hint			Retrieves course data from course id and command
	* 				Provides parsed response data || complete response data and any errors encountered
	*
	* @param 		string command
	* @param 		struct parameters
	*
	* @output		false
	* @returns		any
	*
	*/
	public any function getTrainingData(
		string command = 'course__getList',
		struct parameters = {}
	) {

		local 								= {};
		local.TrainingData					= '';
		local.qStruct 						= {};
		local.command 						= arguments.command;

		if ( getTrainingAPI().getAPIStatus() ) {

			local.apiURL 					=  getTrainingAPI().getBaseURL() & this.setCommand( local.command );

			variables.parameters['p1'] 		= getTrainingAPI().getUsername();
			variables.parameters['p2'] 		= getCourseID();
			variables.parameters['p3'] 		= '';
			variables.parameters['p4'] 		= '';
			variables.parameters['p5'] 		= '';

			local.apiURL 					= local.apiURL & '&' & StructToQueryString( variables.parameters );
			local.Response 					= getAPIData( local.apiURL );

			//DEV: writedump( local.Response  );abort;

			if (
				structkeyexists( local.Response, 'Success' )
				and local.Response['Success'] eq true
			) {

					//SUCCESS
					if (
						structkeyexists( local.Response, 'Data' )
						and isxml( local.Response['Data'] )
					) {

						//XML parse
						local.Response['Data'] 				= XmlParse( local.Response['Data'] );

						//DEV: writedump( local.Response['Data'] );abort;

						if (
							structkeyexists( local.Response['Data'], 'api_result' )
							and structkeyexists( local.Response['Data']['api_result'], 'result' )
						) {

							local.Response['Data'] 			= local.Response['Data']['api_result']['XmlChildren'];
							local.NumberOfCourses 			= ArrayLen( local.Response['Data'] );
							local.CourseList 				= ArrayNew(1);//xmlNew();//
							//local.CourseList['courses'] 	= XmlElemNew( local.CourseList, 'courses' );
							local.NodeCount 				= 1;

							// LOOP OVER COURSE LIST
							for ( CourseItem = 1; CourseItem lte local.NumberOfCourses; CourseItem ++ ) {

								local.apiURL 				= getTrainingAPI().getBaseURL() & this.setCommand( 'course__getRecord' );

								//retrieve course detail
								variables.parameters['p1'] 	= getTrainingAPI().getUsername();
								variables.parameters['p2'] 	= local.Response['Data'][CourseItem]['xmltext'];
								variables.parameters['p3'] 	= '';
								variables.parameters['p4'] 	= '';
								variables.parameters['p5'] 	= '';

								local.apiURL 				= local.apiURL & '&' & StructToQueryString( variables.parameters );
								local.tempData 				= getAPIData( local.apiURL );

								if (
									(
										structkeyexists( local.tempData, 'Success' )
										and local.tempData['Success'] eq true
									)
									and (
										structkeyexists( local.tempData, 'Data' )
										and isxml( local.tempData['Data'] )
									)
									and (
										structkeyexists( XmlParse( local.tempData['Data'] ), 'api_result' )
									)
								) {

									//SUCCESS
									local.CourseData 			= XmlParse( local.tempData['Data'] );

									//local.Course = local.Course['api_result'];

									//is public listing
									local.IsCoursePublic 		= XmlSearch( local.CourseData, '/api_result/publicly_listed' );
									local.CourseSort 			= XmlSearch( local.CourseData, '/api_result/admin_description' );
									local.CourseName 			= XmlSearch( local.CourseData, '/api_result/name' );

									if (
										isarray( local.IsCoursePublic )
										and arraylen( local.IsCoursePublic ) eq 1
										and lcase( local.IsCoursePublic[1].XmlText ) eq 'yes'
									 ) {

										//DEV: writedump( local.Course[item].XmlText  );
										//DEV: writedump( local.CourseData );

										if (
											(
												isarray( local.CourseSort )
												and arraylen( local.CourseSort ) eq 1
												and len( local.CourseSort[1].XmlText ) gt 0
											) and (
												isarray( local.CourseName )
												and arraylen( local.CourseName ) eq 1
												and len( local.CourseName[1].XmlText ) gt 0
											)
										) {

											//Create sort node
											//local.CourseData['api_result'];
											local.SortNode					= XmlElemNew( local.CourseData, 'sort' );//['api_result']
											local.SortNode.XmlText	 		= setSortValue( local.CourseSort[1].XmlText, local.CourseName[1].XmlText );

											xmlPosition 					= arraylen( local.CourseData['api_result'].XMLChildren ) + 1;
											local.CourseData['api_result'].XMLChildren[xmlPosition] = local.SortNode;

											//DEV: writedump( local.SortNode );

										}

										/*
										//DEV:
											//local.CourseNode				= '';
											//writedump( local.CourseSort );
											//writedump( local.CourseName );
											//writedump( local.CourseList['courses'].XMLChildren );
											//append public course data to course list
											//local.CourseList['courses'].XMLChildren[local.NodeCount]				= XmlElemNew( local.CourseList, 'course' );
											//local.CourseList['courses'].XMLChildren[local.NodeCount].XMLText		= [];
											//append course data items course node
										*/
										local.CourseNode[local.NodeCount] = {};

										for ( DataItem in local.CourseData['api_result'].XMLChildren ) {

											local.CourseNode[local.NodeCount][tostring( DataItem.XmlName )] = tostring( DataItem.XmlText );
											/*
											//DEV:
												//local.CourseNode &= '<' & tostring( DataItem.XmlName ) & '>';
												//local.CourseNode &= tostring( DataItem.XmlText );
												//local.CourseNode &= '</' & tostring( DataItem.XmlName ) & '>';
												//writedump( var = tostring( DataItem.XmlName ), label = 'XmlName' );
												//writedump( var = tostring( DataItem.XmlText ), label = 'XmlText' );
											*/

										}

										//DEV: writedump( var = local.CourseNode[local.NodeCount], label= 'local.CourseNode' & local.NodeCount );

										arrayappend( local.CourseList, local.CourseNode[local.NodeCount] );

										//DEV: StructAppend( local.CourseList['courses'].XMLChildren[local.NodeCount], local.CourseNode[local.NodeCount] );// xmlparse( xmlformat( ) );
										//DEV: writedump( local.CourseList );abort;

										//increment node count
										local.NodeCount++;

									}

								} else {

									//results empty
									local.Response['Data'] 		= local;
									local.Response['Errors'] 	= ArrayAppend(
										local.Response['Errors']
										,'Response did not return any results.'
									);

									return local.Response;

								}

							}

							//DEV: writedump( local.CourseList );abort;

							local.Response['Data'] = local.CourseList;

						}  else {

							//results empty
							local.Response['Data'] 		= local;
							local.Response['Errors'] 	= ArrayAppend(
								local.Response['Errors']
								,'Response did not return any results.'
							);

							return local.Response;

						}

					} else {

						//data is not xml
						local.Response['Data'] 		= local;
						local.Response['Errors'] 	= ArrayAppend(
							local.Response['Errors']
							,'Response did not return expected format.'
						);

						return local.Response;

					}

			} else {

				//success but no data
				local.Response['Data'] 		= local;
				local.Response['Errors'] 	= ArrayAppend(
					local.Response['Errors']
					,'Response did not return data.'
				);

				return local.Response;

			}

		} else {

			//Report problem with API Status
			local.Response['Data'] 		= local;

			local.Response['Errors']	= arrayappend(
				local.Response['Errors']
				,'Response API Status ' & getTrainingAPI().getAPIStatus()
			);

		}

		local.TrainingData = local.Response;

		return local.TrainingData;

	}



	/**
	*
	* @name			setSortValue
	* @hint			Parses course API result data to provide sortable value for course list by date then title
	* @param		string desc 	body of data recieved from LMS
	* @param		string title	course name
	*
	* @output		false
	* @returns		string
	*
	*/
	public string function setSortValue( string desc = '', string title = '' ) {

		local 			= {};
		local.title 	= lcase( arguments.title );
		local.DateSort 	= trim( lcase( arguments.desc ) );

		//determine date value is present
		if ( len( local.DateSort ) ) {

			local.DateSort = listGetAt( local.DateSort, 1, '|' );

			//determine whether date string is singular or range
			if (
				ListLen( local.DateSort, '-' ) eq 3
				and len( local.DateSort ) eq 10
			) {

				//reformat provided [yyyy-mm-dd] date string
				if ( isDate( local.DateSort ) ) {

					local.DateSort = DateFormat( local.DateSort, 'YYYYMMDD' );

				}

			} else if (
				ListLen( local.DateSort, '-' ) eq 6
				and len( local.DateSort ) eq 21
			) {

				//remove range from provided [yyyy-mm-dd-yyyy-mm-dd] date string
				local.DateSort = Left( local.DateSort, 10 );

			}

		}

		//verify date string format
		if ( isDate( local.DateSort ) ) {

			local.DateSort = DateFormat( local.DateSort, 'YYYYMMDD' );

		}

		//add title to date string
		local.DateSort = trim( local.DateSort ) & '-' & trim( local.title );//rereplacenocase( , '[^[:digit:]]', '', 'all' )

		return local.DateSort;

	}



	/**
	*
	* @name			ParseDescription
	* @hint			Creates html formatted display string from description data passed from API
	* @param		string desc
	* @param		string delimeter
	*
	* @output		false
	* @returns		string
	*
	*/
	public string function ParseDescription(
			string desc = '',
			string delimeter = '|'
	) {

		local 			= {};
		local.stringOut = trim( arguments.desc );
		local.delimeter = arguments.delimeter;

		if ( listlen( local.stringOut, local.delimeter ) eq 3 ) {

			local.stringOut = ''
					& '<span class="date">'
						& trim( listGetAt( local.stringOut, 1, local.delimeter ) )
						& '</span>'
					& '<span class="location">'
						& trim( listGetAt( local.stringOut, 2, local.delimeter ) )
						& '</span>'
					& '<span class="info">'
						& trim( listGetAt( local.stringOut, 3, local.delimeter ) )
						& '</span>'
				;

		} else if ( listlen( local.stringOut, local.delimeter ) eq 2 ) {

			local.stringOut = ''
					& '<span class="date">'
						& trim( listGetAt( local.stringOut, 1, local.delimeter ) )
						& '</span>'
					& '<span class="location">'
						& trim( listGetAt( local.stringOut, 2, local.delimeter ) )
						& '</span>'
				;

		} else {

			local.stringOut = replace( local.stringOut, '|', '<br/>', 'all' );

		}

		return local.stringOut;

	}



	/**
	*
	* @name			StructToQueryString
	* @hint			Creates query string from struct
	* @param		struct
	*
	* @output		false
	* @returns		string
	*
	*/
	public string function StructToQueryString( struct ) {

		var qstr 			= '';
		var valueDelim 		= '=';
		var variableDelim 	= '&';

		switch ( arrayLen( arguments ) ) {

			case '3':

				variableDelim 	= arguments[3];

			case '2':

				valueDelim 		= arguments[2];

		}

		for ( key in struct ) {

			qstr 	= ListAppend( qstr, URLEncodedFormat( LCase( key ) )
						& valueDelim
						& URLEncodedFormat( struct[key] ), variableDelim );

		}

		return qstr;

	}


	/**
	 * @name		ListToStruct
	 * @hint		Splits a string according to another string or multiple delimiters.
	 *
	 * @param 		string list
	 * @param 		string delimiter
	 *
	 * @output 		false
	 * @return 		struct
	 *
	**/
	public struct function ListToStruct( string list ){

		var newStruct = structNew();
		var delimiter = ',';
		var tempList = arrayNew(1);

		if ( arrayLen( arguments ) gt 1 ) {

			delimiter = arguments[2];

		}

		tempList = listToArray( list, delimiter );

		for ( i = 1; i lte arrayLen( tempList ); i = i + 1 ){

			if ( not structkeyexists( newStruct, trim(ListFirst( tempList[i], '=' ) ) ) ) {

				structInsert( newStruct, trim( listFirst( tempList[i], '=' ) ), trim( listLast( tempList[i], '=' ) ) );

			}

		}

		return newStruct;

	}

	/**
	 *
	 * @name	ArrayStructSort
	 * @hint 	Sorts an array of structures based on a key in the structures.
	 *
	 * @param StructArray 	 Array of structures. (Required)
	 * @param key 	 Key to sort by. (Required)
	 * @param sortOrder 	 Order to sort by, asc or desc. (Optional)
	 * @param sortType 	 Text, textnocase, or numeric. (Optional)
	 * @param delim 	 Delimiter used for temporary data storage. Must not exist in data. Defaults to a period. (Optional)
	 * @return Returns a sorted array.
	 * @author Nathan Dintenfass (&#110;&#97;&#116;&#104;&#97;&#110;&#64;&#99;&#104;&#97;&#110;&#103;&#101;&#109;&#101;&#100;&#105;&#97;&#46;&#99;&#111;&#109;)
	 * @version 1, April 4, 2013
	*/
	public array function ArrayStructSort( StructArray, key ){

		//by default we'll use an ascending sort
		var sortOrder = 'desc';

		//by default, we'll use a textnocase sort
		var sortType = 'textnocase';

		//by default, use ascii character 30 as the delim
		var delim = '.';

		//make an array to hold the sort stuff
		var sortArray = arraynew(1);

		//make an array to return
		var returnArray = arraynew(1);

		//grab the number of elements in the array (used in the loops)
		var count = arrayLen( StructArray );

		//make a variable to use in the loop
		var ii = 1;

		//if there is a 3rd argument, set the sortOrder
		if( arraylen( arguments ) GT 2 )
			sortOrder = arguments[3];

		//if there is a 4th argument, set the sortType
		if( arraylen( arguments ) GT 3 )
			sortType = arguments[4];

		//if there is a 5th argument, set the delim
		if( arraylen( arguments ) GT 4 )
			delim = arguments[5];

		//loop over the array of structs, building the sortArray
		for( ii = 1; ii lte count; ii = ii + 1 )
			sortArray[ii] = StructArray[ii][key] & delim & ii;

		//now sort the array
		arraySort( sortArray, sortType, sortOrder );

		//now build the return array
		for( ii = 1; ii lte count; ii = ii + 1 )
			returnArray[ii] = StructArray[listLast( sortArray[ii], delim )];

		//return the array
		return returnArray;

	}

}