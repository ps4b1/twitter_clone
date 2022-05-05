$('.add_button').each(function(){
    $(this).on("click",function(){
        $(this).closest('span').find('.added_badge').toggle();
        $(this).toggle();
    })
})