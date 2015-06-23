Class {
	#name : #FiDictionaryUpdate,
	#superclass : #FiDictionaryChange,
	#instVars : [
		'newValue',
		'oldValue',
		'child'
	],
	#category : #'FicusExtras-Model-Core-Changes'
}

{ #category : #converting }
FiDictionaryUpdate >> asSimpleChangesAt: aBasePath [

	^ { FiUpdate builder 
			path: aBasePath / key;
			oldValue: oldValue; 
			newValue: newValue; 
			children: (child asSimpleChangesAt: aBasePath / key);
			new } asFiSet
]

{ #category : #accessing }
FiDictionaryUpdate >> child [

	^ child
]

{ #category : #accessing }
FiDictionaryUpdate >> edit [

	^ FiAcceptKey 
		key: key
		edit: (FiEqual value: newValue)
]

{ #category : #accessing }
FiDictionaryUpdate >> inverse [

	^ FiAcceptKey 
		key: key
		edit: (FiEqual value: oldValue)
]

{ #category : #accessing }
FiDictionaryUpdate >> newValue [

	^ newValue
]

{ #category : #accessing }
FiDictionaryUpdate >> oldValue [

	^ oldValue
]
