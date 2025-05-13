# Jenkins-testing
Jenkins pipeline starchers
===========================
[Refer Here](https://www.jenkins.io/doc/book/pipeline/syntax/) Jenkins pipeline starchers 

 sections 
----------
	1. agent -> 
		* any
		* none 
		* label
		* node 
	2. post 
 		* always
		* changed 
		* fixed
		* regression 
		* aborted
		* failure 
		* success
		* unstable
		* unsuccessful
		* clean-up
	3. stages
		* steps 
	4. environment  
		* secret text
		* secret file
		* username and passwd
		* ssh with private key
			call the -- > Name = credentials()
	5. options 
		* retry
		* skipStagesAfterUnstable 
		* skipDefaultCheckout
		* timeout 
	6. parameters
		* string
		* text
		* booleanParam
		* run
		* choice 
		* password 
	7. triggers
		* cron
		* pollSCM
		* upstream 
	8. tools  
	9. input --> this section is used for allowing user approval 
		* message
		* id 
		* ok 
		* submitter  -- name of user
		* submitterParameter
		* parameters 
	10. when 
		* branch
		* buildingTag
		* environment 
		* tag 
		* not --> execute the nested condition is false 
		* allof --> Execute the stage when all of the nested conditions are true.
		* anyOf --> Execute the stage when at least one of the nested conditions is true. 

		* triggeredBy 
		* 
	11. parallel 
	12. sequential Stages 

===============



* in options 
	- timeout ---> The timeout option limits the maximum runtime of the pipeline. In this example, the pipeline will be aborted if it runs longer than 30 minutes.
	- timestamps  ---> The timestamps option adds timestamps to the console output, which is helpful for debugging and monitoring.
	- retry ---> The retry option allows the pipeline to retry failed stages a specified number of times. In this example, each stage will be retried up to 3 times if it fails.
	- quiet Period ---> The quietPeriod option adds a delay (in seconds) before the pipeline starts. This is useful if you want to wait before executing the pipeline (e.g., in case of frequent commits).

* parameters 
	- string --> A string parameter is a simple text input. It’s useful for passing small text values, such as branch names or version numbers.
	- Boolean Parameter ---> A booleanParam parameter creates a checkbox. It’s useful for flags, such as enabling or disabling certain steps in the pipeline.
	- Choice Parameter ---> A choice parameter lets you define a dropdown list of options. This is useful for selecting environments, deployment types, or other predefined options.
	- password parameter ---> A password parameter securely accepts sensitive values like passwords, tokens, or API keys.
	- File Parameter ---> A file parameter allows you to upload a file from your local machine to use within the pipeline. This can be helpful for configuration files or scripts that the pipeline may need.
	- run parametes --> A run parameter lets you select a specific build from another job. This can be helpful for promoting builds or reusing artifacts from previous builds.

====
```
    parameters {
        string(name: 'BRANCH_NAME', defaultValue: 'main', description: 'Branch to build')
        booleanParam(name: 'RUN_TESTS', defaultValue: true, description: 'Run tests after build')
        choice(name: 'ENVIRONMENT', choices: ['development', 'staging', 'production'], description: 'Environment to deploy to')
        password(name: 'SECRET_KEY', defaultValue: 'default', description: 'Enter the secret key')
        file(name: 'CONFIG_FILE', description: 'Upload the configuration file')
        
    }
```

* call the pipeline in 
```
stage(test-params){
	echo 'the branch name is ${params.BRANCH_NAME}'
	when {
		expression { params.RUN_TESTS }  // itis used for run the stage or not 
	}
}
```
groovy
Copy code

scenario-->
------------
 1. In declarative pipeline in 5 stages if stage 2 failed then it should continue to next, not to failed.

	catchError(buildResult: 'SUCCESS', stageResult: 'UNSTABLE')

1. How to check current stage?

# test-libraries
