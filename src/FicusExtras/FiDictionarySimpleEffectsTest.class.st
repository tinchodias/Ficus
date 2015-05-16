Class {
	#name : #FiDictionarySimpleEffectsTest,
	#superclass : #TestCase,
	#category : #'FicusExtras-Tests-Core'
}

{ #category : #tests }
FiDictionarySimpleEffectsTest >> testAddition [

	| shot edit source effect simpleEffects |
	source := FiDictionary new.
	shot := FiChef nickname: #A.

	edit := source editAt: #A equal: shot.
	effect := source effectOf: edit.

	simpleEffects := effect asSimpleEffects.

	simpleEffects := effect asSimpleEffects.

	self 
		assert: (source editFromSimpleEffects: simpleEffects) 
		equals: effect edit.
			
	self assert: simpleEffects equals: 
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
FiDictionarySimpleEffectsTest >> testNoEffect [

	| shot edit source intermediate effect |
	source := FiDictionary new.
	shot := FiChef nickname: #A.

	edit := source editAt: #A equal: shot.
	intermediate := source resultOf: edit.

	edit := intermediate editAt: #A equal: shot.
	effect := intermediate effectOf: edit.

	self assert: effect asSimpleEffects isEmpty.
	
	self 
		assert: (intermediate editFromSimpleEffects: effect asSimpleEffects) 
		equals: effect edit.

]

{ #category : #tests }
FiDictionarySimpleEffectsTest >> testRemoval [

	| edit source shot intermediate effect simpleEffects |
	source := FiDictionary new.
	shot := FiChef nickname: #A.

	edit := source editAt: #A equal: shot.
	intermediate := source resultOf: edit.

	edit := intermediate editExclude: shot nickname.
	effect := intermediate effectOf: edit.

	simpleEffects := effect asSimpleEffects.

	self 
		assert: (intermediate editFromSimpleEffects: simpleEffects) 
		equals: effect edit.
		
	self assert: simpleEffects equals: 
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
FiDictionarySimpleEffectsTest >> testUpdate [

	| shot otherShot edit source intermediate effect simpleEffects |
	source := FiDictionary new.
	shot := FiChef nickname: #A.
	otherShot := shot resultOf: (shot editAt: #shortBio equal: '42').

	edit := source editAt: #A equal: shot.
	intermediate := source resultOf: edit.

	edit := intermediate editAt: #A equal: otherShot.
	effect := intermediate effectOf: edit.

	simpleEffects := effect asSimpleEffects.

	self 
		assert: (intermediate editFromSimpleEffects: simpleEffects) 
		equals: effect edit.

	self assert: simpleEffects equals: 
		(FiSet withValues: {
			(FiUpdate builder
				path: FiPath root / #A;
				children: FiSet new;
				newValue: (FiChef nickname: #A shortBio: '42');
				oldValue: (FiChef nickname: #A);
				new).
			}).	
]
