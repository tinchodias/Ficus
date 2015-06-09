Class {
	#name : #EFiGitRepository,
	#superclass : #EFiRepository,
	#instVars : [
		'repositoryFileReference'
	],
	#category : #'EpiceaFicus-Repositories'
}

{ #category : #convenince }
EFiGitRepository class >> cloneWithoutCheckout2: url in: aFileReference [
	"
	SIGFAULT! (here just for the record)
	
	Clone a (remote or local) repository but do not checkout. This includes fetching all tags :)
	"

	LGitGlobal runSequence: [ 
		| repo remote options remoteCallbacks |
		repo := LGitRepository on: aFileReference.

		"progress bar"
		remote := LGitRemote basicNew
			initializeCallbacks;
			yourself.
		remoteCallbacks :=	remote callbacks.		
		remoteCallbacks
			transferProgress: 
				(LGitTransferProgressCallback on: [ :stats :payload |
					self logCr: 'cb'.
					0 ]).	

		"options"
		options := 
			repo defaultCloneOptions
				freeAfterUse: true;
				remoteCallbacks: remoteCallbacks;
				yourself.
				
		options prim_checkout_opts: 
			(repo defaultCheckoutOptions
				checkoutStrategy: LGitCheckoutStrategyEnum GIT_CHECKOUT_NONE;
				yourself).

		repo
			clone: url
			options: options ]
]

{ #category : #convenince }
EFiGitRepository class >> cloneWithoutCheckout: url in: aFileReference [
	"
	Clone a (remote or local) repository but do not checkout. This includes fetching all tags :)
	
	self 
		cloneWithoutCheckout: EFiIDEWorkingCopyRegistry pharoMetamodelGitUrl 
		in: ('./tmp_cloned_yrupe', Time now asMilliSeconds asString) asFileReference.

	self 
		cloneWithoutCheckout: '/Users/tinchodias/pharo/Playing/yrupe/yrupe-pharo-migrator' 
		in: ('./tmp_cloned_yrupe', Time now asMilliSeconds asString) asFileReference.
	"

	LGitGlobal runSequence: [ 
		| repo options |
		repo := LGitRepository on: aFileReference.
		
		options := 
			repo defaultCloneOptions
				freeAfterUse: true;
				yourself.
				
		options prim_checkout_opts: 
			(repo defaultCheckoutOptions
				checkoutStrategy: LGitCheckoutStrategyEnum GIT_CHECKOUT_NONE;
				yourself).

		[ :bar | 
			bar increment.
			repo clone: url options: options.
			bar increment.
		] asJob 
			title: 'Cloning ', url, ' in ', aFileReference fullName; 
			min: 0;
			max: 2;
			run ]
]

{ #category : #private }
EFiGitRepository >> newRepository [

	| gitRepository |
	self assert: repositoryFileReference exists.
	
	gitRepository := LGitRepository on: repositoryFileReference.
	gitRepository open.
	self assert: gitRepository isInitialized.

	^ gitRepository
]

{ #category : #private }
EFiGitRepository >> newRevisionFor: aLGitCommit [

	^ EFiGitRevision new 
		name: aLGitCommit id hexString; 
		repository: self;
		yourself
]

{ #category : #accessing }
EFiGitRepository >> repositoryFileReference: aFileReference [ 

	repositoryFileReference := aFileReference
]

{ #category : #accessing }
EFiGitRepository >> revisionAtGitTag: aTagName ifPresent: presentBlock ifAbsent: absentBlock [
	
	^ [ | aLGitCommit |
		aLGitCommit := self newRepository revparse: 'refs/tags/', aTagName.
		presentBlock cull: (self newRevisionFor: aLGitCommit) ]
		on: LGit_GIT_ENOTFOUND
		do: absentBlock
]

{ #category : #private }
EFiGitRepository >> revisionsLogAtFilePath: aFilePath startingAt: startingCommit [ 
	"
	FiGitStoreTest basicNew newStore
		revisionsLogAtFilePath: (FiMethodSpot 
			selector: #clear:
			behaviorName: #AthensSurface
			isMetaSide: false
			packageName: 'Athens-Core') asYrupeFilePath
		startingAt: (FiGitStoreTest basicNew newStore newRepository head object)
	"

	| repository walk |
	repository := self newRepository.

	walk := LGitRevwalk of: repository.
	walk pushCommit: startingCommit.
	walk beSortedParentsBeforeChildren.

	^ Array streamContents: [ :str | 
		| lastId |
		lastId := nil.
		[ walk hasNext ] whileTrue: [ 
			| aLGitCommit |
			aLGitCommit := walk next.
			aLGitCommit 
				lookupByPath: aFilePath
				type: LGitObjectTypeEnum GIT_OBJ_ANY
				ifPresent: [ :aLGitObject |
					aLGitObject id = lastId ifFalse: [
						| revision |
						lastId := aLGitObject id.
						revision := self newRevisionFor: aLGitCommit.
						str nextPut: aLGitCommit message lines first -> revision ] ]
				ifAbsent: [	
					lastId ifNotNil: [
						lastId := nil.
						str nextPut: aLGitCommit message lines first -> #absent ] ]
			] ].

]

{ #category : #accessing }
EFiGitRepository >> revisionsLogAtSpot: aFiSpot [ 
	
	^ self 
		revisionsLogAtFilePath: aFiSpot asYrupeFilePath 
		startingAt: self newRepository head object
]

{ #category : #accessing }
EFiGitRepository >> snapshotAtSpot: aFiSpot commitName: hexString [
	
	| aFilePath aLGitCommit |	
	aFilePath := aFiSpot asYrupeFilePath.

	aLGitCommit := self newRepository revparse: hexString.

	aLGitCommit 
		lookupByPath: aFilePath
		type: LGitObjectTypeEnum GIT_OBJ_ANY
		ifPresent: [ :target |
			| encoding |
			encoding := YrEncoding encodingForFilePath: aFilePath.	
			^ YrGitReader new read: target with: encoding ]
		ifAbsent: [ self error ].
]
