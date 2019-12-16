Mood Marbles Agile tool - iOS Client
====================================

### Italy Agile Squad Mood Marble tool
This application is intended to support the the Mood Marble Agile practice.
This instance supports the mobile side of the application.
Web version of this solution can be reached at: http://ibm.biz/moodmarbles

This app has been developed using `Apple XCode` and `Node-Red starter` boilerplate.  

![MM Moods Screenshot](splash-screen.png)
### How does this work?
At first launch of iOS app, you'll be requested to identify yourself filling the information related to the country & department (`Settings` tab). These info are necessary to categorize evaluations under the right organization, given that CloudantDB where data are stored is unique. No other info are stored onto device, to guarantee user's privacy. After that, moving on the `Set Mood` tab, simply press the smiley that better fit with your feeling.
![MM Moods Screenshot](settings.png)

Now, you can start working with app. Simply press the smiley to register user's feedback.

![MM Moods Screenshot](set-moods.png)

A possibility to leave a comment is also included. When done, you could move on the `Comments`tab to visualize the list of marbles for the profiled country & department or you can visualize the overall score selecting `Metrics`tab. Both views show you the last 30 days of activities, to grant you to setup trend metrics.

![MM Chart Screenshot](view-comments.png)   ![MM Evaluations Screenshot](metrics.png)

### Customising Node-RED
This repository is here to be cloned, modified and re-used to allow anyone create
their own Node-RED based application that can be quickly deployed to Bluemix.

![MM Node-Red Screenshot](mm_mobile_flow.png)

The Node-Red flow is stored in the `root` directory in the file called `flow.json`.
When the application is first started, this flow is copied to the attached Cloudant
instance. Otherwise, you could copy the entire flow and paste it into Node-Red, using the import capability.

If you do clone this repository, make sure you update this `README.md` file to point
the `Deploy to Bluemix` button at your repository.

Marco D.
