Class {
	#name : #FiFixedObjectChangesTest,
	#superclass : #TestCase,
	#category : #'Ficus-Tests-Core'
}

{ #category : #tests }
FiFixedObjectChangesTest >> testNoChange [

	| edit change source result |
	source := FiChef nickname: #A.

	edit :=  source editAt: #nickname equal: #A.
	change := source changeOf: edit.
	result := source resultOf: edit.
	
	self assert: change edit equals: FiNoEdit new.
	self assert: change inverse equals: FiNoEdit new.
]

{ #category : #tests }
FiFixedObjectChangesTest >> testUpdate [

	| edit change source result |
	source := FiChef nickname: #A.

	edit :=  source editAt: #shortBio equal: '42'.
	change := source changeOf: edit.
	result := source resultOf: edit.
	
	self assert: change oldValue equals: ''.
	self assert: change edit equals: edit.
	self assert: change inverse equals: (result editAt: #shortBio equal: '').
]

{ #category : #tests }
FiFixedObjectChangesTest >> testUpdateAndSubAddition [

	| source editAdmiredChefs editShortBio edit change result |
	source := FiChef nickname: #A.

	editAdmiredChefs := 
		source 
			editAt: #admiredChefs
			do: [ :admiredChefs | admiredChefs editInclude: #X ].
	editShortBio := 
		source
			editAt: #shortBio
			equal: '42'.

	edit := source editAll: { editAdmiredChefs. editShortBio }.			
	change := source changeOf: edit.
	result := source resultOf: edit.

	self assert: change edit equals: edit.
	self 
		assert: change inverse 
		equals: (result editAll: {(source changeOf: editAdmiredChefs) inverse. (source changeOf: editShortBio) inverse }).
	
	self flag: #todo. "Smells bad that both oldValues are the old comment..."
	self assert: (source changeOf: editShortBio) edit equals: editShortBio.
	self assert: (source changeOf: editShortBio) oldValue equals: ''.
]
