#ifndef __LLIST_H_
#define __LLIST_H_

#include "xil_types.h"
#include <stdlib.h>

typedef struct snap_header {
  uint32_t uncompressed_size;
  uint32_t compressed_size;
  uint64_t addr_in;
  uint64_t addr_out;
} snap_header;

typedef struct node {
  snap_header data;
  struct node * next;
} Node;

typedef struct list {
  Node * head;
  Node * tail;
  uint64_t base_addr_in;
  uint64_t base_addr_out;
} List;



typedef snap_header * snap_header_pt;

List * makelist();
void addToList(snap_header data, List * list);
snap_header * get_next_header(List * list);
void destroylist(List * list);
void advance_tail(List * list);
#endif // _LLIST_H_
