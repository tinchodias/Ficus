Class {
	#name : #RFiClassTraitTest,
	#superclass : #RFiBehaviorTest,
	#category : #'FicusRing-Tests'
}

{ #category : #tests }
RFiClassTraitTest >> testIsTrait [
		
	self assert: resources ringTraitT1 classSide isTrait
]

{ #category : #tests }
RFiClassTraitTest >> testLocalMethods [
		
	self assert: resources ringTraitT1 classSide localMethods size equals: 0
]

{ #category : #tests }
RFiClassTraitTest >> testPackage [
		
	self assert: resources ringTraitT1 classSide package name equals: #X.
]

{ #category : #tests }
RFiClassTraitTest >> testSubclasses [
		
	self assert: resources ringTraitT1 classSide subclasses isEmpty
]
