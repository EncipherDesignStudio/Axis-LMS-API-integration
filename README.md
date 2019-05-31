## Axis LMS API Integration
An integration to display course and registration information from the Atrixware Axis LMS API.


### Development
The use-case for this implementation was to provide a funnel for visitors to explore course offerings, furnish detailed information with calls-to-action to enroll. 

The goal of this integration aimed to retain visitors, and promote registration for interested parties.

The LMS interface would be accessible through a subdomain and branded with assets from the client's primary site to create a seamless transition for users.


#### Code
The *display/training-course-listing.cfm* will give a basic starting point on how to access and display courses.

The first step is to create a new `TrainingService` object with valid credentials:

 
```

    TrainingService = new createObject( 'component', 'TrainingService' );

```

On initialization, the TrainingService creates a TrainingAPI instance necessary to connect to Atrixware.

The TrainingAPI can be accessed within the `TrainingService` through the `TrainingService.getTrainingAPI()` method.

After the TrainingService has been created, it is possible to retrieve data from the LMS API, set up any filters, or conditional display variables.


#### API Commands
The primary method for data retrieval is the `TrainingService.getTrainingData()` method.

Several commands may be passed to this function to access specific data.

The `TrainingService.getTrainingAPI().isCommand()` validates API requests against a list of permitted commands provided by `TrainingService.getTrainingAPI().getCommandList()`. This acts as an extra layer of protection to the data that can be gathered through the API.

Default commands include:

    - system__getApiVersion
    - partition__getCount
    - partition__getList
    - partition__getRecord
    - user__getCount
    - user__getList
    - user__getRecord
    - course__getCount
    - course__getList
    - course__getRecord
    - course__getUserList
    - course__enrollUser
    - report__getCourseInfo

A full list of commands can be found in the documentation linked below.
    


#### Data
The expected response from `TrainingService.getTrainingData()` will be a struct with three values.


```

    - **Success**   :: true || false
    - **Errors**    :: array of error messages || empty array
    - **Data**      :: array|struct|string: array of struct[s], struct of error data, empty string

    
```

Successful responses should return `Data` as an array of sruct[s] containing the necessary values to pass into the TrainingCourse object. 

When `Success` is false, or errors have been generated, `Data` may return a struct containing variables used by the method.

The `Errors` array provides messages regarding errors encountered, and a means to control the display of errors and inform the user of an error.


#### Course List
The default behavior is to list all available courses.

```

    Courses = TrainingService.getTrainingData();

```

The resulting array can then be iterated to create a TrainingCourse object from each struct.



#### Course Details
Detail information for a single Course can be requested based on the presence of a url variable collected by the `TrainingService.getCourseID()`.  

```

    CourseDetail = TrainingService.getTrainingData( 'course__getRecord' );

```

A new TrainingCourse object can be created from the resulting struct.


#### Course 
The TrainingCourse object grants easy access to information needed for the display of each course.

```

    Course = new createObject( 'component', 'TrainingCourse' ).init( course = CourseDetail );

```


#### Filters and Sorting
For the release of this specific integration, the client required a means to sort and filter content based on specifications [ Product and Type of Course ( virtual, on-site, location-specific ) ]. 

Due to API limitations at the time with use of keywords or metadata, codes were devised to prefix the course name that could be extracted for conditional views. 

The variables were added as data attributes and css selectors, used modify display, group courses, filter and sort via the UI.

As an example, the administrator would enter `<product>-<type>-title` as the name in the LMS interface. 


```

    DisplayType = TrainingService.getCourseType();
    DisplayProduct = TrainingService.getCourseProduct();
    DisplayFilter = TrainingService.getFilter();

```
The benefit to this method allowed the creation of tailored lists that could be used within product landing pages or related areas of the site.


#### Recommendations
Though not provided in this example, I highly recommend — erm, _insist_ — on validating any and all data passed into or from the API. 

Refer to, or search for, implementations of the [java org.owasp.esapi:esapi](https://javadoc.io/) classes. 
 
Additionally, I advise caching the output based on the frequency of updates or specific use-cases to reduce API calls.


#### History
The components were originally created for use in the @blueriver MuraCMS, which includes an implementation of the Java Esapi class. 

I've replaced Mura-specific code, such as replacing the `$.getBean()` instantiation with `createObject`, to ease porting them to other frameworks.

In this instance, the account username and key were stored securely and accessed through the bean factory. 

The functions `TrainingService.getTrainingAPI().getKey()` and `TrainingService.getTrainingAPI().getUsername()` may need to be modified for use in similar frameworks.


#### Reference
An Atrixware Axis LMS account with API access is required.

A variation of this code was used in a production environment running Coldfusion 2016+ and LMS API version 10.3+.

This implements only a portion of what is possible through the API, but is a good starting point for development.

Find documentation for the LMS API on the [Atrixware website](https://atrixware.com/) [[API PDF Manual for v10.6](https://files.atrixware.com/files/axis/resources/10.6_manuals/axis-lms.api.pdf)]
