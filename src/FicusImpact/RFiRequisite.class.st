Class {
	#name : #RFiRequisite,
	#superclass : #FiFixedObject,
	#category : #'FicusImpact-Requisites'
}

{ #category : #accessing }
RFiRequisite >> defaultStep [

	^ self shortPrintString
]

{ #category : #printing }
RFiRequisite >> shortPrintString [

	^ self subclassResponsibility
]
