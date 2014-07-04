Class {
	#name : #FiMessageReceiverFactory,
	#superclass : #Object,
	#category : #'FicusImpact-Dependencies'
}

{ #category : #public }
FiMessageReceiverFactory >> messageReceiverFor: aRBNode [ 

	aRBNode isSelf ifTrue: [ ^ FiSelfMessageReceiver new ].

	aRBNode isSuper ifTrue: [ ^ FiSuperMessageReceiver new ].
	
	^ FiAnyMessageReceiver new
]
