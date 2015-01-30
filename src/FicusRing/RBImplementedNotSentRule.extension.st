Extension { #name : #RBImplementedNotSentRule }

{ #category : #'*FicusRing' }
RBImplementedNotSentRule >> checkMethod: aMethod [
	"Check if there are any senders. Furthermore methods with pragmas are likely to be sent through reflection, thus do not report those. Also test methods are sent through reflection, so ignore those as well."
	(self literals includes: aMethod selector)
		ifTrue: [ ^ self ].
	aMethod pragmas isEmpty
		ifFalse: [ ^ self ].
	(aMethod methodClass isMeta not
		and: [ aMethod methodClass isTestCase ])
			ifTrue: [ ^ self ].
	result addMethod: aMethod
]

{ #category : #'*FicusRing' }
RBImplementedNotSentRule >> literals [
	"return all 'message sends' in the systed and cache them"

	literals ifNil: [
		literals := IdentitySet new.

		Smalltalk specialSelectors do: [:sel |
			sel isSymbol ifTrue: [ literals add: sel ] ].
		result rootEnvironment methodsDo: [ :meth |
			meth literals do: [ :lit | self addLiteral: lit ] ] ].
	
	^ literals 
]

{ #category : #'*FicusRing' }
RBImplementedNotSentRule >> resetResultOnEnvironment: rbEnvironment [

	super resetResultOnEnvironment: rbEnvironment.
	literals := nil
]
