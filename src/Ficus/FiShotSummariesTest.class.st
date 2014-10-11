Class {
	#name : #FiShotSummariesTest,
	#superclass : #TestCase,
	#category : #'Ficus-UI-Tests'
}

{ #category : #tests }
FiShotSummariesTest >> testNoEffect [

	| edit effect source |
	source := FiChef nickname: #A.

	edit :=  source at: #nickname equal: #A.
	effect := source effectOf: edit.
	
	self assert: effect flattenedLeafEffects isEmpty.
	self assert: effect hierarchicalSummary isEmpty.

]

{ #category : #tests }
FiShotSummariesTest >> testUpdate [

	| edit effect source |
	source := FiChef nickname: #A.

	edit :=  source at: #shortBio equal: '42'.
	effect := source effectOf: edit.
	
	self 
		assert: effect flattenedLeafEffects 
		equals: { FiPath root / #shortBio -> effect subEffect }.

	self 
		assert: effect hierarchicalSummary asArray
		equals: 
			{ FiSummaryUpdate builder 
				path: #(shortBio) asFicusPath;
				oldValue: ''; 
				newValue: '42'; 
				subSummary: #();
				new }

]

{ #category : #tests }
FiShotSummariesTest >> testUpdateAndSubAddition [

	| source editAdmiredChefs editShortBio edit effect leafEffectOfEditAdmiredChefs leafEffectOfEditShortBio result |
	source := FiChef nickname: #A.

	editAdmiredChefs := 
		source 
			at: #admiredChefs
			edit: [ :admiredChefs | admiredChefs include: #X ].
	editShortBio := 
		source
			at: #shortBio
			equal: '42'.

	edit := source edits: { editAdmiredChefs. editShortBio }.			
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
			FiPath root / #admiredChefs -> leafEffectOfEditAdmiredChefs.
			FiPath root / #shortBio -> leafEffectOfEditShortBio.
			}.

	self 
		assert: effect hierarchicalSummary asSet
		equals: {
			(FiSummaryUpdate builder 
				path: #(admiredChefs) asFicusPath;
				oldValue: source admiredChefs; 
				newValue: result admiredChefs; 
				subSummary: { 
					(FiSummaryAdd builder 
						path: #(admiredChefs X) asFicusPath; 
						newValue: #X; 
						subSummary: #();
						new). };
				new).
			(FiSummaryUpdate builder 
				path: #(shortBio) asFicusPath;
				oldValue: ''; 
				newValue: '42'; 
				subSummary: #();
				new)} asSet
]
