<cfscript>

	TrainingService 	= new CreateObject( 'component', 'TrainingService' );
	DisplayType 		= TrainingService.getCourseType();
	DisplayProduct 		= TrainingService.getCourseProduct();
	DisplayFilter		= TrainingService.getFilter();

	if ( TrainingService.getCourseID() neq '' ) {

		CourseDetail = TrainingService.getTrainingData( 'course__getRecord' );

	} else {

		Courses = TrainingService.getTrainingData();

		if (
			isstruct( Courses )
			and structkeyexists( Courses, 'Data' )
		){

			Courses = Courses['Data'];

		}

		savecontent variable = 'CourseListing' {

			if ( isArray( Courses ) ) {

				//sort array of struct
				Courses = TrainingService.ArrayStructSort( Courses, 'sort', 'asc', 'textnocase' );

				//loop through Courses to display info
				for ( item = 1; item lte ArrayLen( Courses ); item++ ) {

					if ( isStruct( Courses[item] ) ) {

						Course = new CreateObject( 'component', 'TrainingCourse' ).init( course = Courses[item] );

						savecontent variable = 'CourseItem' {

							//output course data
							//writedump( var = Course );

						}

						writeoutput( CourseItem );

					} else if ( Len( Trim( Courses[item] ) ) ) {

						Course = Courses[item];

						//set registration url
						CourseName = Trim( Course );
						RegistrationURL = TrainingService.getRegistrationURL( CourseName );

						//output link

					}

				}

			}

		}

		if ( len( CourseListing ) ) {

			writeoutput( CourseListing );

		} else {

			//no results found message

		}

	}

</cfscript>