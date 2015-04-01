Class {
	#name : #FiRequisite,
	#superclass : #FiFixedObject,
	#category : #'FicusImpact-Requisites'
}

{ #category : #accessing }
FiRequisite >> defaultStep [

	^ self shortPrintString
]

{ #category : #printing }
FiRequisite >> shortPrintString [

	^ self subclassResponsibility
]
