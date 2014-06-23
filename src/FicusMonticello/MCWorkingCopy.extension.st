Extension { #name : #MCWorkingCopy }

{ #category : #'*FicusMonticello' }
MCWorkingCopy >> ficusDifferenceRelativeToRepository: aRepository [

	| snapshotA shotA snapshotB shotB |
	snapshotA := self closestAncestorSnapshotIn: aRepository.
	snapshotB := self completeSnapshot.

	shotA := FiMonticelloMarshaler new marshaled: snapshotA.	
	shotB := FiMonticelloMarshaler new marshaled: snapshotB.	

	^ (shotB differenceFrom: shotA) effectOn: shotA.


]
