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
	
	self assert: effect flattenedLeafEffects isEmpty.
	self assert: effect asSimpleEffects isEmpty.

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
		assert: effect flattenedLeafEffects 
		equals: { FiPath root / #shortBio -> effect subEffect }.

	self 
		assert: effect asSimpleEffects asArray
		equals: 
			{ FiUpdate builder 
				path: #(shortBio) asFicusPath;
				oldValue: ''; 
				newValue: '42'; 
				children: #();
				new }.

	self 
		assert: (source resultOfSimpleEffects: effect asSimpleEffects) 
		equals: (source resultOf: effect edit).
]

{ #category : #tests }
FiFixedObjectSimpleEffectsTest >> testUpdateAndSubAddition [

	| source editAdmiredChefs editShortBio edit effect leafEffectOfEditAdmiredChefs leafEffectOfEditShortBio result |
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

	"These are the 'leaf effects' we expect of #flattenedEffects"
	leafEffectOfEditAdmiredChefs := (source effectOf: editAdmiredChefs) subEffect.
	leafEffectOfEditShortBio := (source effectOf: editShortBio) subEffect.

	self assert: leafEffectOfEditShortBio edit equals: editShortBio edit.
	self assert: leafEffectOfEditShortBio oldValue equals: ''.
	
	self 
		assert: leafEffectOfEditAdmiredChefs flattenedLeafEffects 
		equals: { FiPath root -> leafEffectOfEditAdmiredChefs }.

	self 
		assert: leafEffectOfEditShortBio flattenedLeafEffects 
		equals: { FiPath root -> leafEffectOfEditShortBio }.
			
	self 
		assert: effect flattenedLeafEffects 
		equals: { 
			#(admiredChefs) asFicusPath -> leafEffectOfEditAdmiredChefs.
			#(shortBio) asFicusPath -> leafEffectOfEditShortBio.
			}.

	self 
		assert: effect asSimpleEffects asSet
		equals: {
			(FiUpdate builder 
				path: #(admiredChefs) asFicusPath;
				oldValue: source admiredChefs; 
				newValue: result admiredChefs; 
				children: { 
					(FiAddition builder 
						path: #(admiredChefs X) asFicusPath; 
						newValue: #X; 
						children: #();
						new). };
				new).
			(FiUpdate builder 
				path: #(shortBio) asFicusPath;
				oldValue: ''; 
				newValue: '42'; 
				children: #();
				new)} asSet.
			
	self 
		assert: (source resultOfSimpleEffects: effect asSimpleEffects) 
		equals: (source resultOf: effect edit).
]
