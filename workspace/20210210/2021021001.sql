2021-02-10-01)
2.update��
  - �ش� �ڷᰡ ���̺� ����
  - �ʿ��� �÷��� ���� ����
  (�������)
  update ���̺��
     set �÷���1=��1[,]
        [�÷���2=��2,]
              :
        [�÷���n=��n]
  [where ����];
  .'where ����'���� �����Ǹ� ��� ���� ���� ������  

��) ������̺�(EMPLOYEES)���� �μ���ȣ�� 50�� �μ��� ���� ����� �޿���
    20% �߰��Ͽ� �����Ͻÿ�
  select emp_name as �����,
         department_id as �μ���ȣ,
         salary+(salary*0.2) as �޿�
    from employees
   where department_id=50;
   
(������ ����)
update employees
   set salary=salary+(salary*0.2)
 where department_id=50;
 
select emp_name,salary from employees where department_id=50;
rollback;   

��� ��) ȸ�����̺�(member)���� ȸ����ȣ'f001'ȸ���� �ֹε�Ϲ�ȣ
        (mem_regno1,mem_regno2)�� �������(mem_bir)�� ���� �ڷ��
        �����Ͻÿ�
        1) �ֹι�ȣ1 : 751228 => 021228
           �ֹι�ȣ2 : 1459919 => 3459919
        2)  ������� : 1972/11/04 => 2002/12/28
update member
   set mem_regno1='021228',
       mem_regno2='3459919',
       mem_bir= to_date('20021228')
 where mem_id='f001';
 
select mem_id,mem_regno1,mem_regno2,mem_bir from member where mem_id='f001'

3.delete��
  - ���̺� ����� �ڷḦ  ����
  - where ���� �����Ǹ� �ش����̺��� ��� ���� ����->�� ���̺��� ����
  (�������)
  delete ���̺��
  [where ����];
  .delete���� rollback�� �����

rollback;
��� ��)��ٱ������̺�(cart) 'k001' ȸ���ڷḦ �����Ͻÿ�.
delete cart
 where cart_member='k001';
rollback;
select * from cart where cart_member='k001';
commit;

   