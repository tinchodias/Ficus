Class {
	#name : #YrWorkingCopiesCacheFiller,
	#superclass : #Object,
	#category : #'FicusMonticelloYrupe-Utils'
}

{ #category : #examples }
YrWorkingCopiesCacheFiller class >> benchsOnPrefillingReadCache [

"
* shared 40018 and 40609
=
 count:   60927
 size: 14812268
~=
 count:    7918
 size:  3065386
--> 
 count: 88.49 % shared
 size: 82.85 % shared
"

"
 ((60927 * 100) / (60927+7918)) asFloat.
 ((14812268 * 100) / (14812268+3065386)) asFloat.
 self sum: [ :each | each sourceCode size ].


countOfRemotes := 0.
countOfLocals := 0.
self ficusDeepDo: [ :each |
	each class = FiMethod ifTrue: [ 
		(each privateSourceCode isKindOf: FiRemoteString)
			ifFalse: [ countOfLocals := countOfLocals + 1 ] 
			ifTrue: [ countOfRemotes := countOfRemotes + 1 ] 
	] ].
{ countOfRemotes. countOfLocals }.
"
]

{ #category : #examples }
YrWorkingCopiesCacheFiller class >> packagesAfterPrefillReadCache [
	"
	self packagesAfterPrefillReadCache.

	Before:
	YrReadCache reset.
	
	Test:
	(YrPharoMigrator example1readTag: '40609').
	(YrPharoMigrator example1readTag: '40018').
	"

	| packages |
	packages := MCWorkingCopy allManagers collect: [ :each | 
		MCMethodDefinition flushMethodCache. "Optimization"
		each ficusPackage ].

	self prefillReadCacheWithClassCommentsIn: packages.
	self prefillReadCacheWithMethodsIn: packages.

	^ packages
]

{ #category : #examples }
YrWorkingCopiesCacheFiller class >> prefillReadCacheWithClassCommentsIn: packages [

	packages do: [ :package |
		package ficusDeepDo: [ :each |
			each class = FiClass ifTrue: [ 
				(YrReadCache defaultAtEncodingClass: each comment yrupeLeafEncoder class)
					at: each comment yrupeLeafEncodedSHA1
					put: each privateComment 
			]]]
]

{ #category : #examples }
YrWorkingCopiesCacheFiller class >> prefillReadCacheWithMethodsIn: packages [

	packages do: [ :package |
		package ficusDeepDo: [ :each |
			each class = FiMethod ifTrue: [ 
				(YrReadCache defaultAtEncodingClass: each yrupeLeafEncoder class)
					at: each yrupeLeafEncodedSHA1 
					put: each 
			]]]
]
