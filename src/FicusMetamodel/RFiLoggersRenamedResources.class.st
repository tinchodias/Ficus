"
The only difference with the environment that my superclass describes is that the class belongs to the package 'LoggersRenamed' instead of 'Loggers'. My purpose is testing merge.
"
Class {
	#name : #RFiLoggersRenamedResources,
	#superclass : #RFiFragileBaseClassProblemResources0,
	#category : #'FicusMetamodel-Examples'
}

{ #category : #resources }
RFiLoggersRenamedResources >> categoryNameLoggersCore [

	^ 'LoggersRenamed-Core'
]

{ #category : #resources }
RFiLoggersRenamedResources >> packageLoggers [

	^ FiPackage builder
		name: #LoggersRenamed;
		contents: { self classLog } asFiSet;
		new
]
