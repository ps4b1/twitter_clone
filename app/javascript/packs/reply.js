$(".reply").each(function () {
    $(".reply").on("click",function(){
        $(".reply").closest('div').find('.reply_area').toggle();
        console.log("click")
    })
})