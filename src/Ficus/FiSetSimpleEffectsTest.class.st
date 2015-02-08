Class {
	#name : #FiSetSimpleEffectsTest,
	#superclass : #TestCase,
	#category : #'Ficus-Tests-Core-SimpleEffects'
}

{ #category : #tests }
FiSetSimpleEffectsTest >> testAddition [

	| shot edit source effect simpleEffects |
	source := FiSet new.
	shot := FiChef nickname: #A.

	edit := source editInclude: shot.
	effect := source effectOf: edit.

	simpleEffects := effect asSimpleEffects.

	self 
		assert: (source editFromSimpleEffects: simpleEffects) 
		equals: effect edit.
		
	self assert: simpleEffects equals: 
		(FiSet withValues: {
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
			})
]

{ #category : #tests }
FiSetSimpleEffectsTest >> testNoEffect [

	| shot edit source intermediate effect simpleEffects |
	source := FiSet new.
	shot := FiChef nickname: #A.

	edit := source editInclude: shot.
	intermediate := source resultOf: edit.

	edit := intermediate editInclude: shot.
	effect := intermediate effectOf: edit.

	simpleEffects := effect asSimpleEffects.

	self 
		assert: (intermediate editFromSimpleEffects: simpleEffects) 
		equals: effect edit.
]

{ #category : #tests }
FiSetSimpleEffectsTest >> testRemoval [

	| edit source shot intermediate effect simpleEffects |
	source := FiSet new.
	shot := FiChef nickname: #A.

	edit := source editInclude: shot.
	intermediate := source resultOf: edit.

	edit := intermediate editExclude: shot.
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
FiSetSimpleEffectsTest >> testUpdate [

	| shot otherShot edit source intermediate effect simpleEffects |
	source := FiSet new.
	shot := FiChef nickname: #A.
	otherShot := shot resultOf: (shot editAt: #shortBio equal: '42').

	edit := source editInclude: shot.
	intermediate := source resultOf: edit.

	edit := intermediate editInclude: otherShot.
	effect := intermediate effectOf: edit.

	simpleEffects := effect asSimpleEffects.

	self 
		assert: (intermediate editFromSimpleEffects: simpleEffects) 
		equals: effect edit.
	
	self assert: simpleEffects equals: 
		(FiSet withValues: {
			(FiUpdate builder
				path: FiPath root / #A;
				children: (FiSet withValues: {
					(FiUpdate builder
						path: FiPath root / #A / #shortBio;
						children: FiSet new;
						newValue: '42';
						oldValue: '';
						new).
					});
				newValue: (FiChef nickname: #A shortBio: '42');
				oldValue: (FiChef nickname: #A);
				new).
			}).	
]
