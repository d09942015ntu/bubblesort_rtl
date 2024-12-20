answers=(
"question_2_answer.v"
)
for answer in ${answers[@]};do
  echo "start compile ${answer}"
  iverilog -g2005-sv -o question_2_testbench question_2_testbench.v question_2_gt.v ${answer}

  echo "finish compile ${answer}"
  echo "start running ${answer}"
  vvp question_2_testbench
  echo "finish running ${answer}"
  echo "-------------------"
  rm question_2_testbench

done