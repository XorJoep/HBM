#include "llist.h"

Node * _createnode(snap_header data){
  Node * newNode = malloc(sizeof(Node));

  newNode->data = data;
  newNode->next = NULL;

  return newNode;
}

List * makelist(uint64_t base_addr_in, uint64_t base_addr_out){
  List * list = malloc(sizeof(List));

  list->head = NULL;
  list->tail = NULL;

  list->base_addr_in = base_addr_in;
  list->base_addr_out = base_addr_out;

  return list;
}

void addToList(snap_header data, List * list){
  if(list->tail == NULL){
    list->head = _createnode(data);
    list->tail = list->head;
  }
  else {
  	list->head->next = _createnode(data);
  	list->head = list->head->next;
  }
}

void destroylist(List * list){
	while(list->tail != NULL) {
		advance_tail(list);
	}
	free(list);
}

snap_header_pt get_next_header(List * list) {
	return &list->tail->data;
}

void advance_tail(List * list) {
	Node * previous = list->tail;
	list->tail = list->tail->next;
	free(previous);
}
