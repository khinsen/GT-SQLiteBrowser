Extension { #name : #SQLite3Row }

{ #category : #'*SQLiteBrowser' }
SQLite3Row >> gtDataFor: aView [
	<gtView>
	^ aView forward
		title: 'Data';
		object: [ self asDictionary ];
		view: #gtItemsFor:
]
