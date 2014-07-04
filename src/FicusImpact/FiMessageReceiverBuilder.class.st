Class {
	#name : #FiMessageReceiverBuilder,
	#superclass : #Object,
	#category : #'FicusImpact-Needs'
}

{ #category : #private }
FiMessageReceiverBuilder >> anyMessageReceiver [

	^ FiAnyMessageReceiver new
]

{ #category : #public }
FiMessageReceiverBuilder >> messageReceiverFor: aRBNode [ 

	^ aRBNode acceptVisitor: self
]

{ #category : #'as yet unclassified' }
FiMessageReceiverBuilder >> visitArgumentNode: aRBArgumentNode [ 

	^ self anyMessageReceiver 
]

{ #category : #visitor }
FiMessageReceiverBuilder >> visitArrayNode: aRBArrayNode [ 

	^ self anyMessageReceiver 
]

{ #category : #visitor }
FiMessageReceiverBuilder >> visitAssignmentNode: aRBAssignmentNode [ 

	^ self anyMessageReceiver 
]

{ #category : #visitor }
FiMessageReceiverBuilder >> visitCascadeNode: aRBCascadeNode [ 

	^ self anyMessageReceiver 
]

{ #category : #visitor }
FiMessageReceiverBuilder >> visitLiteralArrayNode: aRBLiteralArrayNode [ 

	^ self anyMessageReceiver 
]

{ #category : #visitor }
FiMessageReceiverBuilder >> visitLiteralNode: aRBLiteralValueNode [ 

	^ self anyMessageReceiver 
]

{ #category : #visitor }
FiMessageReceiverBuilder >> visitMessageNode: aRBMessageNode [ 

	^ self anyMessageReceiver 
]

{ #category : #visitor }
FiMessageReceiverBuilder >> visitSelfNode: aRBSelfNode [ 

	^ FiSelfMessageReceiver new
]

{ #category : #visitor }
FiMessageReceiverBuilder >> visitSuperNode: aRBSuperNode [ 

	^ FiSuperMessageReceiver new
]

{ #category : #visitor }
FiMessageReceiverBuilder >> visitTemporaryNode: aRBTemporaryNode [ 

	^ self anyMessageReceiver 
]

{ #category : #visitor }
FiMessageReceiverBuilder >> visitThisContextNode: aRBThisContextNode [ 

	^ self anyMessageReceiver 
]

{ #category : #visitor }
FiMessageReceiverBuilder >> visitVariableNode: aRBVariableNode [ 

	^ self anyMessageReceiver
]
