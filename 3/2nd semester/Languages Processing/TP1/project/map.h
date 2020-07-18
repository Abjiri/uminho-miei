#ifndef MAP_H
#define MAP_H

struct map;

struct map* mapNew();
void mapAdd(char* key, void* val, struct map* map);
void mapDynAdd(char* key, void* val, struct map* map);
void* mapGet(char* key, struct map* map);
void mapPrint(struct map* map);
void mapCloseMeta(struct map* map);
void mapCloseFiles(struct map* map);

#endif
