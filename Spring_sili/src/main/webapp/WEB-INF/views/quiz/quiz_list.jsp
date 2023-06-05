<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var='root' value="${pageContext.request.contextPath }/"/>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>퀴즈 리스트</title>
<!-- Bootstrap CDN -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/babel-standalone/6.26.0/babel.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/babel-polyfill/6.26.0/polyfill.min.js"></script>
<style>
    .find-btn {
        text-align: center;
    }

    .find-btn1 {
        display: inline-block;
    }

    .question-textarea {
        resize: none;
        width: 100%;
        height: 200px;
    }
</style>
<script>
    var one_check = function () {
        location.href = "${root}quiz_one_check.do";
    }

    var del = function () {
        var quiz_idx = [];
        $("input[name='idx']:checked").each(function (i) {
            quiz_idx.push($(this).val());
        });

        if (quiz_idx.length === 0) {
            alert("글을 선택해 주세요");
            return;
        }

        if (!confirm("삭제 하시겠습니까?")) {
            alert("취소 하셨습니다");
            return;
        }

        $.ajax({
            url: "${root}quiz_del.do",
            type: "post",
            data: { quiz_idx: quiz_idx },
            dataType: "text",
            success: function (data) {
                alert("삭제완료");
                location.href = "${root}quiz_list.do";
            },
            error: function (data) {
                console.log("data==", data);
            },
        });
    }

    var adds = function () {
        var questionCount = $("textarea[name^='question']").length + 1;

        var listHTML = "";
        listHTML += "<div class='form-group' id='content_div'>";
        listHTML += "<label for='question'>" + questionCount + "문제</label>";
        listHTML += "<input type='checkbox' class='btn btn-primary' id='idx' name='idx' value='' />";
        listHTML += "<textarea id='question" + questionCount + "' name='question" + questionCount + "' class='form-control question-textarea' cols='50' rows='20' maxlength='5000' style='resize:none'></textarea>";
        listHTML += "</div>";
        listHTML += "<div class='form-group' id='title_l'>";
        listHTML += "<label for='answer'>답</label>";
        listHTML += "<input type='text' id='answer" + questionCount + "' name='answer" + questionCount + "' class='form-control' maxlength='150'/>";
        listHTML += "<input type='text' name='user_id' id='user_id' value='${chk.user_id}' />";
        listHTML += "</div>";

        $("#tbl1").append(listHTML);
    }

    var edit = function () {
        var questions = [];
        var answers = [];
        var quizIndices = [];
        var user_id = [];

        $("textarea[name^='question']").each(function () {
            questions.push($(this).val());
        });

        $("input[name^='answer']").each(function () {
            answers.push($(this).val());
        });

        $("input[name^='quiz_idx']").each(function () {
            quizIndices.push($(this).val());
        });

        $("input[name='user_id']").each(function () {
            user_id.push($(this).val());
        });


        if (questions.length === 0 || answers.length === 0 || quizIndices.length === 0) {
            alert("수정할 문제가 없습니다");
            return;
        }

        if (!confirm("수정 하시겠습니까?")) {
            alert("취소 하셨습니다");
            return;
        }

        $.ajax({
            url: "${root}quiz_update.do",
            type: "post",
            data: { question: questions, answer: answers, quiz_idx: quizIndices, user_id: user_id },
            dataType: "text",
            success: function (data) {
                alert("수정완료");
                console.log("dd==d=", data)
                location.href = "${root}quiz_main.do";
            },
            error: function (data) {
                console.log("data==", data);
            },
        });
    }
</script>
<c:import url="/WEB-INF/views/include/top_menu.jsp" />
<body>
    <div class="container" style="margin-top:100px">
        <div class="card shadow">
            <div class="card-body" id="view">
                <h4 class="card-title"></h4>
                <table id="tbl1">
                    <input type="button" onclick="edit()" class="btn btn-dange" value="수정하기" />
                    &nbsp;&nbsp;
                    <input type="button" onclick="del()" class="btn btn-dange" value="선택삭제" />
                    &nbsp;&nbsp;
                    <input type="button" onclick="one_check()" class="btn btn-dange" value="하나씩 체크하기 모드" />
                    &nbsp;&nbsp;
                    <input type="button" onclick="adds()" class="btn btn-dange" value="문제 추가하기" />
                    <c:forEach var="obj" items="${chk.chk}" varStatus="status">
                        <div class="form-group" id="content_div">
                            <label for="question">${status.index + 1}문제</label>
                            <input type="checkbox" class="btn btn-primary" id="idx" name="idx" value="${obj.quiz_idx}" />
                            <textarea id="question" name="question" class="form-control question-textarea" cols="50" rows="20" maxlength='5000' style="resize:none">${obj.question}</textarea>
                        </div>
                        <div class="form-group" id="title_l">
                            <label for="answer">답</label>
                            <input type="text" id="answer" name="answer" class="form-control" maxlength='150' value="${obj.answer}" />
                            <input type="hidden" name="quiz_idx" id="quiz_idx" value="${obj.quiz_idx}" />
                            <input type="text" name="user_id" id="user_id" value="${obj.user_id}" />
                        </div>
                    </c:forEach>
                </table>
            </div>
        </div>
    </div>
</body>
</html>
