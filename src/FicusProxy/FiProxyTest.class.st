Class {
	#name : #FiProxyTest,
	#superclass : #TestCase,
	#instVars : [
		'shot',
		'proxy'
	],
	#category : #FicusProxy
}

{ #category : #tests }
FiProxyTest >> testReflexive [

	shot := (FiClass named: #A) tag: 42; yourself.
	proxy := FiProxy new tag: 42; yourself.

	self assert: (shot proxyEquals: shot).
	self assert: (proxy proxyEquals: proxy).
]

{ #category : #tests }
FiProxyTest >> testSymmetricEquals [

	shot := (FiClass named: #A) tag: 42; yourself.
	proxy := FiProxy new tag: 42; yourself.

	self assert: (shot proxyEquals: proxy).
	self assert: (proxy proxyEquals: shot).
	
]

{ #category : #tests }
FiProxyTest >> testSymmetricNotEquals [

	shot := (FiClass named: #A) tag: 42; yourself.
	proxy := FiProxy new tag: 43; yourself.

	self deny: (shot proxyEquals: proxy).
	self deny: (proxy proxyEquals: shot).
	
]
