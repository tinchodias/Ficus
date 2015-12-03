Class {
	#name : #RFiTraitTest,
	#superclass : #RFiBehaviorTest,
	#category : #'FicusRing-Tests'
}

{ #category : #tests }
RFiTraitTest >> testGetName [
		
	self assert: resources ringTraitT1 getName equals: 'T1'
]

{ #category : #tests }
RFiTraitTest >> testIsClass [
		
	self deny: resources ringTraitT1 isClass
]

{ #category : #tests }
RFiTraitTest >> testIsTrait [
		
	self assert: resources ringTraitT1 isTrait
]

{ #category : #tests }
RFiTraitTest >> testLocalMethods [
		
	self assert: resources ringTraitT1 localMethods size equals: 1
]

{ #category : #tests }
RFiTraitTest >> testName [
		
	self assert: resources ringTraitT1 name equals: 'T1'
]

{ #category : #tests }
RFiTraitTest >> testPackage [
		
	self assert: resources ringTraitT1 package name equals: #X.
]

{ #category : #tests }
RFiTraitTest >> testSubclasses [
		
	self assert: resources ringTraitT1 subclasses isEmpty
]
