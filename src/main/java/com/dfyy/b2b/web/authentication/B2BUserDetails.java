package com.dfyy.b2b.web.authentication;

import java.util.Collection;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.security.core.userdetails.UserDetails;

import com.dfyy.b2b.bussiness.User;
import com.dfyy.b2b.bussiness.UserType;

public class B2BUserDetails implements UserDetails {

	private static final long serialVersionUID = 6763082771785222816L;

	private String id;
	private String name;
	private String password;
	private Integer status;
	private UserType type;
	
	public B2BUserDetails(User admin) {
		setId(admin.getId());
		setName(admin.getPhone());
		setPassword(admin.getPassword());
		setStatus(admin.getStatus());
		setType(admin.getType());
	}

	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		return AuthorityUtils.createAuthorityList("PROVIDER");
	}

	@Override
	public String getUsername() {
		return getName();
	}

	@Override
	public String getPassword() {
		return password;
	}

	@Override
	public boolean isAccountNonExpired() {
		return true;
	}

	@Override
	public boolean isAccountNonLocked() {
		return true;
	}

	@Override
	public boolean isCredentialsNonExpired() {
		return true;
	}

	@Override
	public boolean isEnabled() {
		return true;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public UserType getType() {
		return type;
	}

	public void setType(UserType userType) {
		this.type = userType;
	}



}
