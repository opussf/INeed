var app = angular.module('ineedApp', ['angularMoment']);
app.filter('sumOfValue', function() {
	return function(data, key) {
		if (angular.isUndefined(data) || angular.isUndefined(key))
			return 0;
		var sum = 0;
		angular.forEach(data, function(v, k) {
			sum = sum + parseInt(v[key]);
		});
		return sum;
	}
});
app.controller('ineedController', ["$scope", "$http", "$interval", "moment", function( $scope, $http, $interval, moment ) {
$scope.sortReverse = false;
$scope.sortType = 'id';
$scope.displayType='tiles-bs';

$scope.loadData = function() {
	$http.get('ineed.json?date='+new Date())
		.then( function( response ) { 
			$scope.items = response.data.INEED;
			$scope.dataLoadedAt = new Date();
			$scope.dataLastModified = new Date(response.headers("last-modified"));
			// stats
			$scope.haveItemCount = 0; $scope.needItemCount = 0;
			$scope.oldestAddedItem = {"itemID": 0, "date": new Date(), "who": ""};
			$scope.oldestUpdatedItem = {"itemID": 0, "date": new Date(), "who": ""};
			$scope.newestAddedItem = {"itemID": 0, "date": new Date(0), "who": ""};
			$scope.newestUpdatedItem = {"itemID": 0, "date": new Date(0), "who": ""};

			angular.forEach( $scope.items, function( item, key ) {
				let oldestAdded = null; let newestAdded = null;
				let oldestUpdated = null; let newestUpdated = null;
				angular.forEach( item.players, function( player, pkey ) {
					$scope.haveItemCount += player.has;
					$scope.needItemCount += player.needs;

					addedDate = new Date( player.addedTS * 1000 );
					updatedDate = new Date( player.updatedTS * 1000 );
					if (!oldestAdded || addedDate < oldestAdded) {
						oldestAdded = addedDate;
					}
					if (!newestAdded || addedDate > newestAdded) {
						newestAdded = addedDate;
					}
					if (!oldestUpdated || updatedDate < oldestUpdated) {
						oldestUpdated = updatedDate;
					}
					if (!newestUpdated || updatedDate > newestUpdated) {
						newestUpdated = updatedDate;
					}
					
					if (player.addedTS*1000 < ($scope.oldestAddedItem.date.getTime())) {
						$scope.oldestAddedItem = {"itemID": item.id, "date": addedDate, "who": player.name + " - " + player.realm};
					};
					if (player.updatedTS*1000 < ($scope.oldestUpdatedItem.date.getTime())) {
						$scope.oldestUpdatedItem = {"itemID": item.id, "date": updatedDate, "who": player.name + " - " + player.realm};
					};
					if (player.addedTS*1000 > ($scope.newestAddedItem.date.getTime())) {
						$scope.newestAddedItem = {"itemID": item.id, "date": addedDate, "who": player.name + " - " + player.realm};
					};
					if (player.updatedTS*1000 > ($scope.newestUpdatedItem.date.getTime())) {
						$scope.newestUpdatedItem = {"itemID": item.id, "date": updatedDate, "who": player.name + " - " + player.realm};
					};
						
				});
				item.oldestAdded = oldestAdded.toISOString();
				item.newestAdded = newestAdded.toISOString();
				item.oldestUpdated = oldestUpdated.toISOString();
				item.newestUpdated = newestUpdated.toISOString();
				console.log( item );
			});
		} ) 
};

//initial load
$scope.loadData();

var reload = $interval( function() { 
	$scope.loadData();
	console.log("Reload here");
	}, 60000);

} ] );

