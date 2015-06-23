Class {
	#name : #FiDictionarySimpleChangesTest,
	#superclass : #TestCase,
	#category : #'FicusExtras-Tests-Core'
}

{ #category : #tests }
FiDictionarySimpleChangesTest >> testAddition [

	| shot edit source change simpleChanges |
	source := FiDictionary new.
	shot := FiChef nickname: #A.

	edit := source editAt: #A equal: shot.
	change := source changeOf: edit.

	simpleChanges := change asSimpleChanges.

	simpleChanges := change asSimpleChanges.

	self 
		assert: (source editFromSimpleChanges: simpleChanges) 
		equals: change edit.
			
	self assert: simpleChanges equals: 
		((FiSet withValues: {
			(FiAddition builder
				path: FiPath root / #A;
				children: (FiSet withValues: {
					(FiAddition builder
						path: FiPath root / #A / #admiredChefs;
						children: FiSet new;
						newValue: FiSet new;
						new).
					(FiAddition builder
						path: FiPath root / #A / #recipes;
						children: FiSet new;
						newValue: FiSet new;
						new).
					(FiAddition builder
						path: FiPath root / #A / #nickname;
						children: FiSet new;
						newValue: #A;
						new).
					(FiAddition builder
						path: FiPath root / #A / #shortBio;
						children: FiSet new;
						newValue: '';
						new).
					});
				newValue: (FiChef nickname: #A);
				new).
			})).
]

{ #category : #tests }
FiDictionarySimpleChangesTest >> testNoChange [

	| shot edit source intermediate change |
	source := FiDictionary new.
	shot := FiChef nickname: #A.

	edit := source editAt: #A equal: shot.
	intermediate := source resultOf: edit.

	edit := intermediate editAt: #A equal: shot.
	change := intermediate changeOf: edit.

	self assert: change asSimpleChanges isEmpty.
	
	self 
		assert: (intermediate editFromSimpleChanges: change asSimpleChanges) 
		equals: change edit.

]

{ #category : #tests }
FiDictionarySimpleChangesTest >> testRemoval [

	| edit source shot intermediate change simpleChanges |
	source := FiDictionary new.
	shot := FiChef nickname: #A.

	edit := source editAt: #A equal: shot.
	intermediate := source resultOf: edit.

	edit := intermediate editExclude: shot nickname.
	change := intermediate changeOf: edit.

	simpleChanges := change asSimpleChanges.

	self 
		assert: (intermediate editFromSimpleChanges: simpleChanges) 
		equals: change edit.
		
	self assert: simpleChanges equals: 
		(FiSet withValues: {
			(FiRemoval builder
				path: FiPath root / #A;
				children: (FiSet withValues: {
					(FiRemoval builder
						path: FiPath root / #A / #admiredChefs;
						children: FiSet new;
						oldValue: FiSet new;
						new).
					(FiRemoval builder
						path: FiPath root / #A / #recipes;
						children: FiSet new;
						oldValue: FiSet new;
						new).
					(FiRemoval builder
						path: FiPath root / #A / #nickname;
						children: FiSet new;
						oldValue: #A;
						new).
					(FiRemoval builder
						path: FiPath root / #A / #shortBio;
						children: FiSet new;
						oldValue: '';
						new).
					});
				oldValue: (FiChef nickname: #A);
				new).
			}).
]

{ #category : #tests }
FiDictionarySimpleChangesTest >> testUpdate [

	| shot otherShot edit source intermediate change simpleChanges |
	source := FiDictionary new.
	shot := FiChef nickname: #A.
	otherShot := shot resultOf: (shot editAt: #shortBio equal: '42').

	edit := source editAt: #A equal: shot.
	intermediate := source resultOf: edit.

	edit := intermediate editAt: #A equal: otherShot.
	change := intermediate changeOf: edit.

	simpleChanges := change asSimpleChanges.

	self 
		assert: (intermediate editFromSimpleChanges: simpleChanges) 
		equals: change edit.

	self assert: simpleChanges equals: 
		(FiSet withValues: {
			(FiUpdate builder
				path: FiPath root / #A;
				children: FiSet new;
				newValue: (FiChef nickname: #A shortBio: '42');
				oldValue: (FiChef nickname: #A);
				new).
			}).	
]
