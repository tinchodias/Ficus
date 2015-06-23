Class {
	#name : #FiFixedObjectSimpleChangesTest,
	#superclass : #TestCase,
	#category : #'Ficus-Tests-Core'
}

{ #category : #tests }
FiFixedObjectSimpleChangesTest >> testHasChangeAt [

	| source editAdmiredChefs change simpleChanges |
	source := FiChef nickname: #A.

	editAdmiredChefs := 
		source 
			editAt: #admiredChefs
			do: [ :admiredChefs | admiredChefs editInclude: #X ].

	change := source changeOf: editAdmiredChefs.
	simpleChanges := change asSimpleChanges.

	self assert: (simpleChanges asArray first hasChangeAt: FiPath root / #admiredChefs / #X).
	self deny: (simpleChanges asArray first hasChangeAt: FiPath root / #admiredChefs / #Y).
]

{ #category : #tests }
FiFixedObjectSimpleChangesTest >> testNoChange [

	| edit change source |
	source := FiChef nickname: #A.

	edit :=  source editAt: #nickname equal: #A.
	change := source changeOf: edit.
	
	self 
		assert: (source editFromSimpleChanges: change asSimpleChanges) 
		equals: change edit.

]

{ #category : #tests }
FiFixedObjectSimpleChangesTest >> testUpdate [

	| edit change source simpleChanges |
	source := FiChef nickname: #A.

	edit :=  source editAt: #shortBio equal: '42'.
	change := source changeOf: edit.

	simpleChanges := change asSimpleChanges.

	self 
		assert: (source editFromSimpleChanges: simpleChanges) 
		equals: change edit.
	
	self assert: simpleChanges equals: 
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
FiFixedObjectSimpleChangesTest >> testUpdateAndSubAddition [

	| source editAdmiredChefs editShortBio edit change result simpleChanges |
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

	simpleChanges := change asSimpleChanges.

	self 
		assert: (source editFromSimpleChanges: simpleChanges) 
		equals: change edit.

	self assert: simpleChanges equals: 
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
