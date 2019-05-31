<cfscript>
	/**
	*
	* 	Access and display LMS courses
	*
	*/
	TrainingService 	= new createObject( 'component', 'TrainingService' );

	//variables to conditionally create views
	DisplayType 		= TrainingService.getCourseType();
	DisplayProduct 		= TrainingService.getCourseProduct();
	DisplayFilter		= TrainingService.getFilter();

	if ( TrainingService.getCourseID() neq '' ) {

		//requests information for a specific course
		CourseDetail = TrainingService.getTrainingData( 'course__getRecord' );

		if (
			isStruct( CourseDetail )
			and (
				structKeyExists( CourseDetail, 'Errors' )
				and (
					isArray( CourseDetail['Errors'] )
					and arrayIsEmpty( CourseDetail['Errors'] )
				)
			)
			and structKeyExists( CourseDetail, 'Data' )
		){

			Course = new createObject( 'component', 'TrainingCourse' ).init( course = CourseDetail );

			//output course details if no errors
			//DEV: writedump( var = Course );

		} else {

			//message:: no results found
			writeoutput( '<p>' );
			writeoutput( 'The course name <strong>' );
			writeoutput( url.id );
			writeoutput( '</strong> was not found, or is not offered at this time.' );
			writeoutput( '</p>' );

		}


	} else {

		Courses = TrainingService.getTrainingData();

		if (
			isStruct( Courses )
			and (
				structKeyExists( Courses, 'Errors' )
				and (
					isArray( Courses['Errors'] )
					and arrayIsEmpty( Courses['Errors'] )
				)
			)
			and structKeyExists( Courses, 'Data' )
		){

			Courses = Courses['Data'];

		}

		savecontent variable = 'CourseListing' {

			if ( isArray( Courses ) ) {

				//sort array of structs
				Courses = TrainingService.ArrayStructSort( Courses, 'sort', 'asc', 'textnocase' );

				//loop through Courses to display info
				for ( item = 1; item lte arrayLen( Courses ); item++ ) {

					if ( isStruct( Courses[item] ) and ! structIsEmpty( Courses[item] ) ) {

						Course = new createObject( 'component', 'TrainingCourse' ).init( course = Courses[item] );

						savecontent variable = 'CourseItem' {

							//output course data
							//DEV: writedump( var = Course );

						}

						writeoutput( CourseItem );

					}
					//should catch odd cases where course data returns only the course name
					else if ( len( trim( Courses[item] ) ) ) {

						Course = Courses[item];

						//set registration url
						CourseName = trim( Course );
						RegistrationURL = TrainingService.getRegistrationURL( CourseName );

						//format/output link

					}

				}

			}

		}

		if ( len( CourseListing ) ) {

			writeoutput( CourseListing );

		} else {

			//message:: no results found

		}

	}

</cfscript>