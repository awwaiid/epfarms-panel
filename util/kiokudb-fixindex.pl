$|=1;
use '../lib';
use EPFarms;
$db=EPFarms::DB->new;
@all=$db->db->all_objects->all;
$i=0;
$count=scalar @all;
foreach $obj (@all) {
    $i++;
    $db->db->store($obj);
    printf "$i/$count (%.02f)\r",($i/$count*100)
}

