//CPSC 331
//Safian Omar Qureshi
//ID 10086638
//Assignment 2 Part 2 Question 1

//The following code was provided to us in tutorial week 5. I modified the methods minimally to 
//fit with the requirements of the assignment 2 part 2 question 1 

public class SLL<T> {
    protected SLLNode<T> head, tail;
    public SLL() {
        head = tail = null;
    }
    public boolean isEmpty() {
        return head == null;
    }
    public void addToHead(T el) {
        head = new SLLNode<T>(el,head);
        if (tail == null)
            tail = head;
    }
    public void addToTail(T el) {
        if (!isEmpty()) {
            tail.next = new SLLNode<T>(el);
            tail = tail.next;
        }
        else head = tail = new SLLNode<T>(el);
    }
    public T deleteFromHead() { // delete the head and return its info; 
        if (isEmpty()) 
             return null;
        T el = head.info;
        if (head == tail)       // if only one node on the list;
             head = tail = null;
        else head = head.next;
        return el;
    }
    public T deleteFromTail() { // delete the tail and return its info;
        if (isEmpty()) 
             return null;
        T el = tail.info;
        if (head == tail)       // if only one node in the list;
             head = tail = null;
        else {                  // if more than one node in the list,
             SLLNode<T> tmp;    // find the predecessor of tail;
             for (tmp = head; tmp.next != tail; tmp = tmp.next);
             tail = tmp;        // the predecessor of tail becomes tail;
             tail.next = null;
        }
        return el;
    }
    public void delete(T el) {  // delete the node with an element el;
        if (!isEmpty())
            if (head == tail && el.equals(head.info)) // if only one
                 head = tail = null;       // node on the list;
            else if (el.equals(head.info)) // if more than one node on the list;
                 head = head.next;    // and el is in the head node;
            else {                    // if more than one node in the list
                 SLLNode<T> pred, tmp;// and el is in a nonhead node;
                 for (pred = head, tmp = head.next;  
                      tmp != null && !tmp.info.equals(el); 
                      pred = pred.next, tmp = tmp.next);
                 if (tmp != null) {   // if el was found;
                     pred.next = tmp.next;
                     if (tmp == tail) // if el is in the last node;
                        tail = pred;
                 }
            }
    }
    public void printAll() {
        for (SLLNode<T> tmp = head; tmp != null; tmp = tmp.next)
            System.out.print(tmp.info + " ");                
    }
    public boolean isInList(T el) {
        SLLNode<T> tmp;
        for (tmp = head; tmp != null && !tmp.info.equals(el); tmp = tmp.next);
        return tmp != null;
    }
  
  // assuming list1 and list2 are sorted already
  public static <T extends Comparable<? super T>> 
    void union(SLL<T> list1, SLL<T> list2,
               SLL<T> result) {
    
    SLLNode<T> iterlist1 = list1.head;
    SLLNode<T> iterlist2 = list2.head;
    
    T itemlist1=null, itemlist2=null;
    
    // get first item in each list
    if ( iterlist1 != null )
      itemlist1 = iterlist1.info;
    if( iterlist2 != null )
      itemlist2 = iterlist2.info;
    
    while ( itemlist1 != null || itemlist2 != null ) {

      int compareResult;
      if( itemlist1 == null ) {
        compareResult = 1;
      } else if ( itemlist2 == null ) {
        compareResult = -1;
      } else {
        compareResult = itemlist1.compareTo(itemlist2);
      }
      
      if ( compareResult == 0 ) {
        result.addToTail(itemlist1); //appending to result list 
        if( iterlist1.next != null ) {
          iterlist1 = iterlist1.next;
          itemlist1 = iterlist1.info;
        } else {
          itemlist1 = null;
        }
        
        if( iterlist2.next != null ) {
          iterlist2 = iterlist2.next;
          itemlist2 = iterlist2.info;
        } else {
          itemlist2 = null;
        }  
      }
      else if ( compareResult < 0 ) {  
        result.addToTail(itemlist1); //appending to result list
        if( iterlist1.next != null ) {
          iterlist1 = iterlist1.next;
          itemlist1 = iterlist1.info;
        } else {
          itemlist1 = null;
        }
      }
      else {
        result.addToTail(itemlist2);
        if( iterlist2.next != null ) {
          iterlist2 = iterlist2.next;
          itemlist2 = iterlist2.info;
        } else {
          itemlist2 = null;
        }
      }
    }     
  } 

  // assuming list1 and list2 are sorted already
  public static <T extends Comparable<? super T>>
  void intersection(SLL<T> list1, SLL<T> list2, SLL<T> result) {

  SLLNode<T> iterlist1 = list1.head;
  SLLNode<T> iterlist2 = list2.head;

  T itemlist1=null, itemlist2=null;

  // get first item in each list
  if ( iterlist1 != null && iterlist2 != null ) {
    itemlist1 = iterlist1.info;
    itemlist2 = iterlist2.info;
  }

  while ( itemlist1 != null && itemlist2 != null ) {
    int compareResult = itemlist1.compareTo(itemlist2);
    
    if ( compareResult == 0 ) {
      result.addToTail(itemlist1); //append to result list
      if( iterlist1.next != null ) {
        iterlist1 = iterlist1.next;
        itemlist1 = iterlist1.info;
      } else {
        itemlist1 = null;
      }
      
      if( iterlist2.next != null ) {
        iterlist2 = iterlist2.next;
        itemlist2 = iterlist2.info;
      } else {
        itemlist2 = null;
      }       
    }
    else if ( compareResult < 0 ) {  
      if( iterlist1.next != null ) {
        iterlist1 = iterlist1.next;
        itemlist1 = iterlist1.info;
      } else {
        itemlist1 = null;
      }
    }
    else {
      if( iterlist2.next != null ) {
        iterlist2 = iterlist2.next;
        itemlist2 = iterlist2.info;
      } else {
        itemlist2 = null;
      }
    }
  }
  }

}

