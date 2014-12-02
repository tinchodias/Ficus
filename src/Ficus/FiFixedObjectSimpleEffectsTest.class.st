Class {
	#name : #FiFixedObjectSimpleEffectsTest,
	#superclass : #TestCase,
	#category : #'Ficus-Tests-Core-SimpleEffects'
}

{ #category : #tests }
FiFixedObjectSimpleEffectsTest >> testNoEffect [

	| edit effect source |
	source := FiChef nickname: #A.

	edit :=  source editAt: #nickname equal: #A.
	effect := source effectOf: edit.
	
	self 
		assert: (source resultOfSimpleEffects: effect asSimpleEffects) 
		equals: (source resultOf: effect edit).
]

{ #category : #tests }
FiFixedObjectSimpleEffectsTest >> testUpdate [

	| edit effect source |
	source := FiChef nickname: #A.

	edit :=  source editAt: #shortBio equal: '42'.
	effect := source effectOf: edit.
	
	self 
		assert: (source resultOfSimpleEffects: effect asSimpleEffects) 
		equals: (source resultOf: effect edit).
		
	self assert: effect asSimpleEffects equals: 
		(FiSet withValues: {
			(FiUpdate builder
				path: FiPath root / #shortBio;
				children: FiSet new;
				newValue: '42';
				oldValue: '';
				new).
			}).
			
]

{ #category : #tests }
FiFixedObjectSimpleEffectsTest >> testUpdateAndSubAddition [

	| source editAdmiredChefs editShortBio edit effect result simpleEffects |
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
	effect := source effectOf: edit.
	result := source resultOf: edit.

	simpleEffects := effect asSimpleEffects.

	self 
		assert: (source resultOfSimpleEffects: effect asSimpleEffects) 
		equals: (source resultOf: effect edit).

	self assert: simpleEffects equals: 
		(FiSet withValues: {
			(FiUpdate builder
				path: FiPath root / #admiredChefs;
				children: (FiSet withValues: {
					(FiAddition builder
						path: FiPath root / #admiredChefs / #X;
						children: FiSet new;
						newValue: #X;
						new).
					});
				newValue: #(X) asFiSet;
				oldValue: #() asFiSet;
				new).
			(FiUpdate builder
				path: FiPath root / #shortBio;
				children: FiSet new;
				newValue: '42';
				oldValue: '';
				new).
			}).
			
]
