document.addEventListener('DOMContentLoaded', function () {
    const modal = document.getElementById('addNewsModal');
    const closeButton = document.querySelector('.modal-content .close');
    const closeFormButton = document.getElementById('closeBtn');
    const form = document.getElementById('news-form');

    // 打开模态框
    function openModal() {
        modal.style.display = 'block';
    }

    // 关闭模态框
    function closeModal() {
        modal.style.display = 'none';
    }

    // 点击关闭按钮或表单取消按钮关闭模态框
    closeButton.addEventListener('click', closeModal);
    closeFormButton.addEventListener('click', closeModal);

    // 点击模态框外部关闭模态框
    window.addEventListener('click', (event) => {
        if (event.target === modal) {
            closeModal();
        }
    });

    form.addEventListener('submit', function (event) {
        event.preventDefault();  // 阻止表单默认提交行为
        const formData = new FormData(form);  // 获取表单数据
        // 发送 POST 请求
        fetch('/web/newupload', {
            method: 'POST',
            body: formData,
        })
            .then(response => response.json())  // 解析 JSON 响应
            .then(data => {
                // 弹出提示框显示成功信息
                if (data.message) {
                    alert(data.message);  // 如果服务器返回消息，弹窗显示
                }
            })
            .catch(error => {
                console.error('yes', error);
                alert("上传成功！");
                location.reload();
            });
    });



    // 删除新闻操作
    document.querySelectorAll('.delete-btn').forEach(button => {
        button.addEventListener('click', function () {
            const newsId = button.getAttribute('data-id');
            if (confirm('确定删除这条新闻吗?')) {
                fetch('/web/deleteNews', {
                    method: 'POST',
                    body: new URLSearchParams({ newsId }),
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded'
                    }
                })
                    .then(response => response.json())
                    .then(data => {
                        alert(data.message || '删除成功！');
                        location.reload(); // 删除后刷新页面
                    })
                    .catch(error => {
                        console.error('Error:', error);
                        alert('删除失败，请稍后再试！');
                    });
            }
        });
    });


// 点击取消按钮关闭模态框
    document.getElementById('cancelUpdate').addEventListener('click', function () {
        document.getElementById('updateModal').style.display = 'none';
        document.getElementById('modalOverlay').style.display = 'none';
    });


    // 打开模态框的按钮
    document.querySelector('.add-news-btn').addEventListener('click', openModal);
});
