document.addEventListener('DOMContentLoaded', function() {
    const tabList = document.querySelector('.tab-list');
    const tabAddBtn = document.querySelector('.tab-add-btn');
    let tabCounter = 1;

    // Lưu trữ dữ liệu hóa đơn cho mỗi tab
    const billsData = {};

    // Khởi tạo dữ liệu cho tab đầu tiên
    billsData[1] = createEmptyBill();

    let activeTabId = 1;

    function createEmptyBill() {
        return {
            items: [],
            totalAmount: '0đ',
            discount: '0đ',
            finalAmount: '0đ',
            customer: '',
            note: ''
        };
    }

    function saveCurrentBillState() {
        if (!billsData[activeTabId]) return;

        billsData[activeTabId] = {
            items: Array.from(document.querySelectorAll('.bill-items .bill-item')).map(item => item.outerHTML),
            totalAmount: document.querySelector('.summary-row:nth-child(1) span:last-child').textContent,
            discount: document.querySelector('.summary-row:nth-child(2) span:last-child').textContent,
            finalAmount: document.querySelector('.summary-row:nth-child(3) span:last-child').textContent,
            customer: document.getElementById('search-phone').value,
            note: document.querySelector('.bill-summary textarea').value
        };
    }

    function loadBillState(tabId) {
        if (!billsData[tabId]) return;

        const billData = billsData[tabId];

        document.querySelector('.bill-items').innerHTML = billData.items.join('');
        document.querySelector('.summary-row:nth-child(1) span:last-child').textContent = billData.totalAmount;
        document.querySelector('.summary-row:nth-child(2) span:last-child').textContent = billData.discount;
        document.querySelector('.summary-row:nth-child(3) span:last-child').textContent = billData.finalAmount;
        document.getElementById('search-phone').value = billData.customer;
        document.querySelector('.bill-summary textarea').value = billData.note;
        document.querySelector('.bill-header h4').textContent = `Hóa đơn #${tabId}`;

        attachDeleteButtonListeners();
    }

    function attachDeleteButtonListeners() {
        document.querySelectorAll('.bill-items .bill-item button').forEach(button => {
            button.addEventListener('click', function() {
                this.closest('.bill-item').remove();
                saveCurrentBillState();
            });
        });
    }

    function createNewTab() {
        saveCurrentBillState();

        tabCounter++;

        const newTab = document.createElement('div');
        newTab.classList.add('tab');
        newTab.dataset.tabId = tabCounter;
        newTab.innerHTML = `<span>Hóa đơn #${tabCounter}</span><button class="tab-close">&times;</button>`;

        tabAddBtn.insertAdjacentElement('beforebegin', newTab);

        newTab.addEventListener('click', function() {
            saveCurrentBillState();
            document.querySelectorAll('.tab').forEach(tab => tab.classList.remove('active'));
            newTab.classList.add('active');
            activeTabId = parseInt(newTab.dataset.tabId);
            loadBillState(activeTabId);
        });

        newTab.querySelector('.tab-close').addEventListener('click', function(e) {
            e.stopPropagation();
            if (newTab.classList.contains('active')) {
                const prevTab = newTab.previousElementSibling || newTab.nextElementSibling;
                if (prevTab && prevTab !== tabAddBtn) {
                    prevTab.click();
                }
            }
            delete billsData[newTab.dataset.tabId];
            newTab.remove();
        });

        billsData[tabCounter] = createEmptyBill();
        newTab.click();
    }

    const firstTab = document.querySelector('.tab');
    if (firstTab) {
        firstTab.addEventListener('click', function() {
            document.querySelectorAll('.tab').forEach(tab => tab.classList.remove('active'));
            this.classList.add('active');
            activeTabId = parseInt(this.dataset.tabId || 1);
            loadBillState(activeTabId);
        });

        firstTab.querySelector('.tab-close').addEventListener('click', function(e) {
            e.stopPropagation();
            alert('Không thể đóng tab đầu tiên');
        });

        firstTab.dataset.tabId = 1;
    }

    tabAddBtn.addEventListener('click', createNewTab);

    window.tabSystem = {
        getActiveTabId: () => activeTabId,
        saveCurrentBillState: saveCurrentBillState,
        loadBillState: loadBillState
    };
});




// add new customer
const buttonAddCustomer = document.getElementById("save-customer-button");
buttonAddCustomer.addEventListener("click", function (event){
    if(!validateCustomerForm()){
        event.preventDefault();
    } else {
        addCustomer();
    }

});

async function addCustomer() {
    let customerData = {
        cusName: document.getElementById("customer-name").value.trim(),
        cusPhone: document.getElementById("customer-phone").value.trim(),
        cusAddress: document.getElementById("customer-address").value.trim()
    };

    console.log(customerData);
    try {
        let response = await fetch("/api/addcustomer", {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify(customerData)
        });

        let result = await response.json();

        if (response.ok) {
            showToast("Thêm khách hàng thành công!", true);
            let modal = bootstrap.Modal.getInstance(document.getElementById("customerModal"));
            modal.hide();
        } else {
            showToast("Lỗi: " + result.message, false);
        }
    } catch (error) {
        console.error("Lỗi khi gửi yêu cầu:", error);
        showToast("Có lỗi xảy ra, vui lòng thử lại!", false);
    }
}
function validateCustomerForm() {
    let isValid = true;

    // Lấy giá trị nhập vào
    let name = document.getElementById("customer-name").value.trim();
    let phone = document.getElementById("customer-phone").value.trim();
    let address = document.getElementById("customer-address").value.trim();

    let phoneError = document.getElementById("phone-error");
    let nameError = document.getElementById("name-error");
    let addressError = document.getElementById("address-error");

    if (name === "") {
        nameError.hidden = false;
        isValid = false;
    }

    let phoneRegex = /^(0[2-9]{1}[0-9]{8,9})$/;
    if (!phoneRegex.test(phone)) {
        phoneError.hidden = false;
        isValid = false;
    } else {
        phoneError.hidden = true;
    }
    if (address === "") {
        addressError.hidden = false;
        isValid = false;
    }
    return isValid;
}

function showToast(message, isSuccess = true) {
    let toastElement = document.getElementById("toastMessage");

    toastElement.querySelector(".toast-body").textContent = message;
    toastElement.classList.remove("bg-success", "bg-danger");
    toastElement.classList.add(isSuccess ? "bg-success" : "bg-danger");

    let toast = new bootstrap.Toast(toastElement);
    toast.show();
}

//reset form
document.addEventListener("DOMContentLoaded", function () {
    let customerModal = document.getElementById("customerModal");

    customerModal.addEventListener("hidden.bs.modal", function () {
        document.getElementById("customer-name").value = "";
        document.getElementById("customer-phone").value = "";
        document.getElementById("customer-address").value = "";

        document.getElementById("name-error").hidden = true;
        document.getElementById("phone-error").hidden = true;
        document.getElementById("address-error").hidden = true;
    });
});

//search customer by Phone
document.addEventListener("DOMContentLoaded", function () {
    const searchInput = document.getElementById("search-phone");
    const suggestionBox = document.getElementById("suggestion-box");

    // Hàm gọi API tìm kiếm khách hàng theo số điện thoại
    async function searchCustomer(phone) {
        if (phone.length < 3) {
            suggestionBox.style.display = "none";
            return;
        }

        try {
            const response = await fetch(`/api/customers/search?phone=${phone}`);
            if (!response.ok) {
                throw new Error(`API trả về lỗi: ${response.status}`);
            }

            const result = await response.json();
            console.log(result);
            // Kiểm tra nếu `result.data` không phải là một mảng
            if (!result.data || !Array.isArray(result.data)) {
                console.error("Lỗi: API không trả về danh sách khách hàng hợp lệ!", result);
                return;
            }

            showSuggestions(result.data);
        } catch (error) {
            console.error("Lỗi khi tìm khách hàng:", error);
        }
    }

    function showSuggestions(customers) {
        suggestionBox.innerHTML = ""; // Xóa dữ liệu cũ
        if (customers.length === 0) {
            suggestionBox.style.display = "none";
            return;
        }

        customers.slice(0, 5).forEach(customer => {
            const option = document.createElement("div");
            option.classList.add("suggestion-item", "p-2", "border-bottom");
            option.textContent = `${customer.phone} - ${customer.name}`;
            option.style.cursor = "pointer";

            // Khi click vào một gợi ý -> Điền vào ô input
            option.addEventListener("click", () => {
                searchInput.value = `${customer.phone} - ${customer.name}`;
                suggestionBox.style.display = "none"; // Ẩn gợi ý sau khi chọn
            });

            suggestionBox.appendChild(option);
        });

        suggestionBox.style.display = "block"; // Hiển thị box
    }


    searchInput.addEventListener("input", () => {
        const phone = searchInput.value.trim();
        searchCustomer(phone);
    });

    document.addEventListener("click", function (event) {
        if (!suggestionBox.contains(event.target) && event.target !== searchInput) {
            suggestionBox.style.display = "none";
        }
    });
});