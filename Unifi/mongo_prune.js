var _____WB$wombat$assign$function_____ = function(name) {return (self._wb_wombat && self._wb_wombat.local_init && self._wb_wombat.local_init(name)) || self[name]; };
if (!self.__WB_pmw) { self.__WB_pmw = function(obj) { this.__WB_source = obj; return this; } }
{
	let window = _____WB$wombat$assign$function_____("window");
	let self = _____WB$wombat$assign$function_____("self");
	let document = _____WB$wombat$assign$function_____("document");
	let location = _____WB$wombat$assign$function_____("location");
	let top = _____WB$wombat$assign$function_____("top");
	let parent = _____WB$wombat$assign$function_____("parent");
	let frames = _____WB$wombat$assign$function_____("frames");
	let opener = _____WB$wombat$assign$function_____("opener");

// keep N-day worth of data
var days=7;

// change to false to have the script to really exclude old records
// from the database. While true, no change at all will be made to the DB
var dryrun=true;

var now = new Date().getTime(),
	time_criteria = now - days * 86400 * 1000,
	time_criteria_in_seconds = time_criteria / 1000;

print((dryrun ? "[dryrun] " : "") + "pruning data older than " + days + " days (" + time_criteria + ")... ");

db = db.getSiblingDB('ace');
var collectionNames = db.getCollectionNames();
for (i=0; i<collectionNames.length; i++) {
	var name = collectionNames[i];
	var query = null;

	if (name === 'event' || name === 'alarm') {
		query = {time: {$lt:time_criteria}};
	}

	// rogue ap
	if (name === 'rogue') {
		query = {last_seen: {$lt:time_criteria_in_seconds}};
	}

	// removes vouchers expired more than '$days' ago
	// active and unused vouchers are NOT touched
	if (name === 'voucher') {
		query = {end_time: {$lt:time_criteria_in_seconds}};
	}

	// guest authorization
	if (name === 'guest') {
		query = {end: {$lt:time_criteria_in_seconds}};
	}

	// if an user was only seen ONCE, $last_seen will not be defined
	// so, if $last_seen not defined, lets use $first_seen instead
	// also check if $blocked or $use_fixedip is set. If true, do NOT purge the
	// entry no matter how old it is. We want blocked/fixed_ip users to continue
	// blocked/fixed_ip. Also noted users should not be deleted.
	if (name === 'user') {
		query = { blocked: { $ne: true}, use_fixedip: { $ne: true}, noted: { $ne: true}, $or: [
				{last_seen: {$lt:time_criteria_in_seconds} },
				{last_seen: {$exists: false}, first_seen: {$lt:time_criteria_in_seconds} }
			]
		};
	}

	if (query) {
		count1 = db.getCollection(name).count();
		count2 = db.getCollection(name).find(query).count();
		print((dryrun ? "[dryrun] " : "") + "pruning " + count2 + " entries (total " + count1 + ") from " + name + "... ");
		if (!dryrun) {
			db.getCollection(name).remove(query);
			db.runCommand({ compact: name });
		}
	}
}

if (!dryrun) db.repairDatabase();

db = db.getSiblingDB('ace_stat');
var collectionNames = db.getCollectionNames();
for (i=0; i<collectionNames.length; i++) {
	var name = collectionNames[i];
	var query = null;

	// historical stats (stat.*)
	if (name.indexOf('stat')==0) {
		query = {time: {$lt:time_criteria}};
	}

	if (query) {
		count1 = db.getCollection(name).count();
		count2 = db.getCollection(name).find(query).count();
		print((dryrun ? "[dryrun] " : "") + "pruning " + count2 + " entries (total " + count1 + ") from " + name + "... ");
		if (!dryrun) {
			db.getCollection(name).remove(query);
			db.runCommand({ compact: name });
		}
	}
}

if (!dryrun) db.repairDatabase();


}
/*
	FILE ARCHIVED ON 15:40:54 Jun 14, 2022 AND RETRIEVED FROM THE
	INTERNET ARCHIVE ON 08:15:05 Jan 14, 2023.
	JAVASCRIPT APPENDED BY WAYBACK MACHINE, COPYRIGHT INTERNET ARCHIVE.

	ALL OTHER CONTENT MAY ALSO BE PROTECTED BY COPYRIGHT (17 U.S.C.
	SECTION 108(a)(3)).
*/
/*
playback timings (ms):
	captures_list: 376.704
	exclusion.robots: 0.064
	exclusion.robots.policy: 0.057
	cdx.remote: 0.055
	esindex: 0.008
	LoadShardBlock: 348.949 (3)
	PetaboxLoader3.datanode: 326.086 (6)
	PetaboxLoader3.resolve: 239.053 (2)
	CDXLines.iter: 17.235 (3)
	load_resource: 234.784
*/
