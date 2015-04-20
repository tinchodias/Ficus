Class {
	#name : #RFiRequisite,
	#superclass : #FiFixedObject,
	#category : #'FicusImpact-Model'
}

{ #category : #accessing }
RFiRequisite >> defaultStep [

	^ self shortPrintString
]

{ #category : #printing }
RFiRequisite >> shortPrintString [

	^ self subclassResponsibility
]
