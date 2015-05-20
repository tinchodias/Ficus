Class {
	#name : #YrFsPharoExporter,
	#superclass : #Object,
	#category : #'FicusMonticelloYrupe-Migration'
}

{ #category : #'as yet unclassified' }
YrFsPharoExporter >> export: anObject to: aFileReference [

	| writer |
	writer := YrFsWriter newWithFileReference: aFileReference.
	
	"create contents"
	anObject yrupeDefaultEncoder 
		write: anObject
		at: 'contents'
		on: writer.

	"create readme"
	writer
		at: 'README.md' 
		writeAsLeaf: self readmeString.

]

{ #category : #'as yet unclassified' }
YrFsPharoExporter >> exportWorkingCopiesTo: aFileReference [

	| time packages |
	time := [
	packages := MCWorkingCopy allManagers collect: [ :each | each ficusPackage ].
	] timeToRun.
	
	FileStream stdout << 'creating packages: ' << time asString.
	
	time := [
	self export: packages asFiSet to: aFileReference.
	] timeToRun.
	
	FileStream stdout << 'writing packages: ' << time asString.

]

{ #category : #'as yet unclassified' }
YrFsPharoExporter >> readmeString [
	
	^ 'Automatically created by Yrupe.'
]
