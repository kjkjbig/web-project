document.addEventListener('DOMContentLoaded', function() {
    // ฟอร์มล็อกอิน
    const loginForm = document.getElementById('loginForm');

    // เมื่อฟอร์มถูก submit (เช่น กดปุ่มหรอกด Enter)
    loginForm.addEventListener('submit', async function(event) {
        event.preventDefault(); // ป้องกันการ reload หน้า

        // ดึงข้อมูลจากฟอร์ม
        const email = document.getElementById('email').value;
        const telephone = document.getElementById('telephone').value;

        // ส่งข้อมูลไปที่ /login ผ่าน fetch
        try {
            const response = await fetch('/login', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({ email, telephone }) // ส่งข้อมูลเป็น JSON
            });

            // if (response.ok) {
            //     // ถ้าล็อกอินสำเร็จ redirect ไปยังหน้าหลัก
            //     window.location.href = '/';
            // } else {
            //     // แสดงข้อความว่า email หรือ telephone ไม่ถูกต้อง
            //     const errorText = await response.text();
            //     document.getElementById('error-message').innerText = errorText;
            // }
        } catch (err) {
            console.error('Error:', err);
        }
    });
});

document.addEventListener('DOMContentLoaded', () => {
    const form = document.getElementById('checkinForm');

    form.addEventListener('submit', async (event) => {
        event.preventDefault(); // ป้องกันการรีเฟรชหน้าหลังจากกด submit

        // ดึงค่าจาก input field
        const id1 = document.getElementById('id').value;
        const section_id1 = document.getElementById('sectionID').value;
        const student_id = document.getElementById('studentID').value;
        const date = document.getElementById('date').value;

        const id = await pool.query(`
            SELECT id
            FROM student 
            WHERE id = $1
        `, [id1]);
        

        const section_id =await pool.query(`
            SELECT section_id 
            FROM student 
            WHERE section_id = $1
        `, [section_id1]);

        try {
            const response = await fetch('/submit-checkin', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({ id, section_id, student_id, date })
            });

            // ตรวจสอบสถานะการตอบกลับจากเซิร์ฟเวอร์
            const resultText = await response.text();
            document.body.innerHTML += resultText; // แสดง alert จากเซิร์ฟเวอร์

        } catch (error) {
            alert('Error submitting check-in data.');
            console.error('Error:', error);
        }
    });
});



document.addEventListener("DOMContentLoaded", function() {
    const addStudentForm = document.querySelector('form'); // เลือกฟอร์ม
    addStudentForm.addEventListener('submit', async function(e) {
        e.preventDefault(); // ป้องกันการ submit แบบปกติ

        // สร้างข้อมูลนักเรียนจากฟอร์ม
        const studentData = {
            id: document.getElementById('id').value,
            prefix_id: document.getElementById('prefix').value,
            first_name: document.getElementById('firstName').value,
            last_name: document.getElementById('lastName').value,
            date_of_birth: document.getElementById('dob').value,
            sex: document.getElementById('sex').value,
            previous_school: document.getElementById('previousSchool').value,
            address: document.getElementById('address').value,
            telephone: document.getElementById('telephone').value,
            email: document.getElementById('email').value,
            line_id: document.getElementById('lineId').value,
            curriculum_id: document.getElementById('curriculum').value
        };

        try {
            // ส่งคำขอไปยังเซิร์ฟเวอร์เพื่อเพิ่มนักเรียน
            const response = await fetch('/add-student', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(studentData)
            });

            // ตรวจสอบสถานะการตอบกลับ
            if (response.ok) {
                alert('Student added successfully!');
                addStudentForm.reset(); // ล้างฟอร์มหลังจากเพิ่มนักเรียนเรียบร้อยแล้ว
            } else {
                const errorData = await response.json();
                alert('Error: ' + errorData.message);
            }
        } catch (error) {
            console.error('Error:', error);
            alert('An error occurred while adding the student.');
        }
    });
});
