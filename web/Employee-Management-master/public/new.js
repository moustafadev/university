function updateDeptOptions(select) {
    const deptSelect = document.getElementById('dept-select');
    // Clear all options except the first one
    deptSelect.options.length = 1;
    if (select.value === 'Admin') {
      // Add options for Administrator and Manager
      deptSelect.add(new Option('Administrator', 'Administrator'));
      deptSelect.add(new Option('Manager', 'Manager'));
    } else if (select.value === 'Employee') {
      // Add options for Technical Support Specialist, Web Developer, and Marketing Specialist
      deptSelect.add(new Option('Technical Support Specialist', 'Technical Support Specialist'));
      deptSelect.add(new Option('Web Developer', 'Web Developer'));
      deptSelect.add(new Option('Client', 'Client'));
      deptSelect.add(new Option('Marketing Specialist', 'Marketing Specialist'));
    }
  }