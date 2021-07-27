input_id = input("아이디를 입력하세요.\n")
input_pwd = input("비밀번호를 입력하세요.\n")
input_pi = input("사원번호를 입력하세요.\n")
real_id = "egoing"
real_pwd = "11"
real_pi = "22"
if real_id == input_id:
    if real_pwd == input_pwd:
        if real_pi == input_pi:
            print("hello!")
    else:
        print("잘못된 입력입니다.")
else:
    print("who are you?")
