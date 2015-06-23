Class {
	#name : #FiSetSimpleChangesTest,
	#superclass : #TestCase,
	#category : #'Ficus-Tests-Core'
}

{ #category : #tests }
FiSetSimpleChangesTest >> testAddition [

	| shot edit source change simpleChanges |
	source := FiSet new.
	shot := FiChef nickname: #A.

	edit := source editInclude: shot.
	change := source changeOf: edit.

	simpleChanges := change asSimpleChanges.

	self 
		assert: (source editFromSimpleChanges: simpleChanges) 
		equals: change edit.
		
	self assert: simpleChanges equals: 
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
FiSetSimpleChangesTest >> testNoChange [

	| shot edit source intermediate change simpleChanges |
	source := FiSet new.
	shot := FiChef nickname: #A.

	edit := source editInclude: shot.
	intermediate := source resultOf: edit.

	edit := intermediate editInclude: shot.
	change := intermediate changeOf: edit.

	simpleChanges := change asSimpleChanges.

	self 
		assert: (intermediate editFromSimpleChanges: simpleChanges) 
		equals: change edit.
]

{ #category : #tests }
FiSetSimpleChangesTest >> testRemoval [

	| edit source shot intermediate change simpleChanges |
	source := FiSet new.
	shot := FiChef nickname: #A.

	edit := source editInclude: shot.
	intermediate := source resultOf: edit.

	edit := intermediate editExclude: shot.
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
FiSetSimpleChangesTest >> testUpdate [
	<expectedFailure>
	| shot otherShot edit source intermediate change simpleChanges |
	source := FiSet new.
	shot := FiChef nickname: #A.
	otherShot := shot resultOf: (shot editAt: #shortBio equal: '42').

	edit := source editInclude: shot.
	intermediate := source resultOf: edit.

	edit := intermediate editInclude: otherShot.
	change := intermediate changeOf: edit.

	simpleChanges := change asSimpleChanges.

	self 
		assert: (intermediate editFromSimpleChanges: simpleChanges) 
		equals: change edit.
	
	self assert: simpleChanges equals: 
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
