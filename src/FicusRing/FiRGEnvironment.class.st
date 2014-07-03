"
I am polymorphic with SystemDictionary, fetching everything needed from a Ficus environment.
"
Class {
	#name : #FiRGEnvironment,
	#superclass : #FiRGShot,
	#instVars : [
		'packagesShot'
	],
	#category : #FicusRing
}

{ #category : #polymorphism }
FiRGEnvironment >> allClasses [

	^ Array streamContents: [ :stream |
		packagesShot 
			valuesDo: [ :packageShot |
				stream nextPutAll: 
					(packageShot contents values 
						select: #isFicusClass 
						thenCollect: [ :classShot |
							FiRGClass new 
								environment: self; 
								shot: classShot;
								yourself ]) ] ]
]

{ #category : #polymorphism }
FiRGEnvironment >> at: aName ifAbsent: aBlockClosure [ 

	^ self 
		at: aName 
		ifPresent: [ :value | value ]
		ifAbsent: aBlockClosure
]

{ #category : #polymorphism }
FiRGEnvironment >> at: aName ifPresent: presentBlock ifAbsent: absentBlock [

	self allClasses 
		detect: [ :aPClass | aPClass name = aName ]
		ifFound: [ :aPClass | ^ presentBlock cull: aPClass ]
		ifNone: [ ^ absentBlock value ]

]

{ #category : #polymorphism }
FiRGEnvironment >> classNamed: aName [
	
	^ self at: aName ifAbsent: [ NotFound signal ]
]

{ #category : #accessing }
FiRGEnvironment >> environmentShot [
	
	^ packagesShot
]

{ #category : #accessing }
FiRGEnvironment >> environmentShot: anObject [
	
	packagesShot := anObject
]
