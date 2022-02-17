package com.seoulauction.common.auth;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import java.util.Collection;
import java.util.List;

public class SAUserDetails implements UserDetails {

	private String loginId;
    private int userNo;
    private String password;
    private List<GrantedAuthority> authorities;
    private String userKind; 
    
	public SAUserDetails(String loginId, String password, int userNo, List<GrantedAuthority> authorities) {
    	this.loginId = loginId;
		this.password = password;
		this.userNo = userNo;
		this.authorities = authorities;
	}
    
    public SAUserDetails(String loginId, String password, int userNo, List<GrantedAuthority> authorities, String userKind) {
    	this.loginId = loginId;
		this.password = password;
		this.userNo = userNo;
		this.authorities = authorities;
		this.userKind = userKind;
	}
    
    @Override
    public String getUsername() {
    	return this.loginId;
    }
    
	@Override
	public String getPassword() {
		return this.password;
	}

	public int getUserNo() {
		return userNo;
	}
	
    public String getUserKind() {
		return userKind;
	}

	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
        return this.authorities;
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

}
