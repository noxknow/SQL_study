SELECT AO.ANIMAL_ID, AO.NAME FROM ANIMAL_OUTS AO
LEFT OUTER JOIN ANIMAL_INS AI 
ON AO.ANIMAL_ID = AI.ANIMAL_ID
WHERE AI.ANIMAL_ID IS NULL;
-- -> 이 부분의 경우 outs 테이블에 ins 테이블 id가 없는 행이 있다면 그 행을 null로 판단하게 되고 그런 null 값이 된 부분을 select 해준다.
